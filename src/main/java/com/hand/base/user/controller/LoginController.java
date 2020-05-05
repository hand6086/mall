package com.hand.base.user.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.naming.AuthenticationException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextImpl;
import org.springframework.security.web.savedrequest.DefaultSavedRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hand.base.basic.model.AppContext;
import com.hand.base.common.model.Menu;
import com.hand.base.common.service.MenuService;
import com.hand.base.enterprise.service.EnterpriseService;
import com.hand.base.user.model.LoginLog;
import com.hand.base.user.model.OnlineUser;
import com.hand.base.user.model.User;
import com.hand.base.user.service.LoginLogService;
import com.hand.base.user.service.LoginService;
import com.hand.base.user.service.OnlineUserService;
import com.hand.core.basic.listener.BindSession;
import com.hand.core.util.AppConstants;
import com.hand.core.util.DateUtil;
import com.hand.core.util.IpUtil;
import com.hand.core.util.RedisUtil;
import com.hand.core.util.StringUtils;

import redis.clients.jedis.Jedis;

@Controller
@RequestMapping("/action/portal/login")
public class LoginController{
	
	private static final Logger logger = LogManager.getLogger(LoginController.class);
	@Resource
	private LoginService loginService;
	@Resource
	private OnlineUserService onlineUserService;
	@Resource
	private LoginLogService loginLogService;
	@Resource
	private MenuService menuService;
	
	@Resource
	private EnterpriseService enterpriseService;
	/**
	 * 设置【内部用户】和【外部用户】登录的公共必要信息
	 * @param  设置信息的登录用户
	 */
	private User loginSettings(HttpSession session, HttpServletRequest request,HttpServletResponse response) throws Exception{
		SecurityContext securityContext = (SecurityContext) session.getAttribute("SPRING_SECURITY_CONTEXT");
		if(securityContext == null){
			logger.warn("获取不到登录用户信息，可能是用户未登录或者Session过期");
			throw new Exception("获取不到登录用户信息，可能是用户未登录或者Session过期");
		}
		Authentication auth = securityContext.getAuthentication();
		if (auth == null) {
			logger.warn("获取不到登录用户信息");
			throw new Exception("获取不到登录用户信息");
		}
		User user = (User) auth.getPrincipal();
		if( !"OUTER_EMP".equals(user.getEmpType()) && ! "INTER_EMP".equals(user.getEmpType())&&!"BRAND_EMP".equals(user.getEmpType())){
			throw new Exception("无法获取当前用户类型");
		}
		session.setAttribute("UserContext", user);
		//获取登录用户所属的企业信息，并且存到session里
		//Enterprise userEnterprise = enterpriseService.queryByCode(user.getCorpid());
		//session.setAttribute("UserEnterpriseContext", userEnterprise);
		
		
		
		/*int errorTimes = getLoginErrorTimes(user.getUsername());
		if(errorTimes >= 5){
			throw new Exception("登录错误次数过多！");
		}*/
		
		setLoginErrorTimes(user.getUsername(), 0);//清空登录错误次数
		// addOnlineEmp(user, session, request);//添加到在线用户列表
		loginService.lastLoginDateUpdate(user);//更新最后登录时间
		
		/*String ip = IpUtil.getIpAddress(request);//IpUtil获取IP地址
		LoginLog record = new LoginLog();
		record.setLockFlag('N');
		String userAgent = request.getHeader("User-Agent");
        record.setUserId(user.getId());
        record.setLoginName(user.getUsername());
        record.setSessionId(session.getId());
        record.setIpAddress(ip);
        record.setUserAgent(userAgent);
        record.setUserSource("CRM");//crm用户登录
		loginLogService.addLoginSuccessLog(record);*/
		
		// 添加添加页面公共参数
		AppContext actx = new AppContext();
		actx.setPicShareUrl(AppConstants.portalShareUrlDir);
		actx.setCtxPath(request.getContextPath());
		actx.setEmpType(user.getEmpType());
		actx.setFstName(user.getFirstName());
		actx.setStoreName(user.getStoreName());
		session.setAttribute("AppContext", actx);
		//系统日期
		Date dt=new Date();
	    SimpleDateFormat matter=new SimpleDateFormat("yyyy-MM-dd");
		session.setAttribute("currentDate", matter.format(dt));
		
		return user;
	}
	
	/**
	 * 内部用户登录入口
	 */
	@RequestMapping(value="/login")
	public String login(HttpSession session, HttpServletRequest request,HttpServletResponse response) {  
		try {
			
			String defaultHomePage = "/portal/home/home1.jsp";//系统默认的首页
            String storeDataFillingPage="/store_info.jsp";//入驻商户信息维护页
            //String storeCheckPendingPage="/portal/enterprise/CheckPending.jsp"; //待审批页面
            String storeCheckPendingPage="/store_info.jsp"; //待审批页面
            String storePayPage="/portal/enterprise/depositPayment.jsp";//押金支付页面
            String storeAgreementPage="/portal/enterprise/AgreementPage.jsp";//协议确认界面
            session.setAttribute("homePageCRM", defaultHomePage);
			session.setAttribute("loginType", "CRM");//区分由CRM系统登录界面进入
			
			User user = loginSettings(session,request,response);//设置登录的必要信息
			
			if(!StringUtils.equals(user.getEmpType(), "INTER_EMP") && !StringUtils.equals(user.getEmpType(), "BRAND_EMP")){
			    throw new BadCredentialsException("该入口只允许内部用户或入驻商户登录。");
			}
			
			 //跳转到登录前请求的页面 HttpSessionRequestCache.SAVED_REQUEST = "SPRING_SECURITY_SAVED_REQUEST"
            DefaultSavedRequest savedRequest = (DefaultSavedRequest) request.getSession().getAttribute("SPRING_SECURITY_SAVED_REQUEST");
	       	 if(savedRequest != null){
	       		 String path = savedRequest.getServletPath();
	       		 String queryStr = savedRequest.getQueryString();
	       		 if(!StringUtils.isBlank(path) && !StringUtils.isBlank(queryStr) && queryStr.contains("openOrgin=true")){
	       			if(path.endsWith(".jsp")){
	       				path+= "?"+queryStr;
	       				return "redirect:"+ path;
	       			}
	       		 }
	       	 }
	       
	       	if(StringUtils.equals(user.getEmpType(), "INTER_EMP")){
	       		
	       		if(StringUtils.isNull(user.getCorpName())){
					throw new BadCredentialsException("请联系管理员维护公司账套！");
				}
	       		
	       		//获取一级菜单
	            List<Menu> list = menuService.queryFstMenuList(user.getId());
	            session.setAttribute("menuList", list);
	       		
	       		return "redirect:" + defaultHomePage;
	       	 }else {
	       		 switch(user.getStoreStatus()){
		       		 case "REGISTERED": return "redirect:" + storeDataFillingPage;
		       		 case "CHECK_PENDING" : return "redirect:" + storeCheckPendingPage;
		       		 case "AUDIT_PASSED" : return "redirect:" + storePayPage;
		       		 case "PASSED_NOPAID" : return "redirect:" + storePayPage;
		       		 case "AUDIT_REJECT": return "redirect:" + storeDataFillingPage;
		       		 case "ALREADY_PAID" : return "redirect:" + storeAgreementPage;
		       		 case "SIGNED" : 
		       			 //获取一级菜单
		 	            List<Menu> list = menuService.queryFstMenuList(user.getId());
		 	            session.setAttribute("menuList", list);
		       			return "redirect:" + defaultHomePage;
		       		 default :return "redirect:/login.jsp";
	       		 }
	       	 }
		} catch (BadCredentialsException e) {
			logger.error("登录失败", e);
			session.setAttribute("SPRING_SECURITY_LAST_EXCEPTION",e);
			return "redirect:/login.jsp";
		} catch (Exception e) {
			logger.error("获取登录用户失败", e);
			return "redirect:/login.jsp";
		}
	}
	
	/**
	 * 外部用户登录入口
	 */
	@RequestMapping(value="/partnerlogin")
	public String partnerlogin(HttpSession session, HttpServletRequest request,HttpServletResponse response) {  
		try {
			session.setAttribute("loginType", "DMS");//区分由DMS系统登录界面进入
			User user = loginSettings(session,request,response);//设置登录的必要信息
			//查询购物车中的产品数量
			try {
				
			} catch (Exception e) {
				e.printStackTrace();
				session.setAttribute("shopCartProdCount", 0);
			}
			
			if(!StringUtils.equals(user.getEmpType(), "OUTER_EMP")){
			    //throw new BasicControllerException("获取登录用户信息失败");
			    throw new BadCredentialsException("该入口只允许外部用户登录");
			}
			//获取DMS菜单
            List<Menu> list = menuService.queryDmsMenuByUserId(user.getId());
            session.setAttribute("dmsMenuList", list);
            
            loadUserAccessURLToRedis(user);//加载用户不可访问URL到缓存中
            return "redirect:/partner/main/home.jsp";
		} catch (BadCredentialsException e) {
			logger.error("登录失败", e);
			session.setAttribute("SPRING_SECURITY_LAST_EXCEPTION",e);
			return "redirect:/partner/login.jsp";
		} catch (Exception e) {
			logger.error("获取登录用户失败", e);
			return "redirect:/partner/login.jsp";
		}
	}
	
	/**
	 * 设置【内部用户】和【外部用户】登录失败的公共必要信息
	 */
	private void loginfailSettings(HttpSession session, HttpServletRequest request,HttpServletResponse response) throws Exception{
		SecurityContextImpl securityContext = (SecurityContextImpl) request.getSession().getAttribute("SPRING_SECURITY_CONTEXT");
		Object exception = session.getAttribute("SPRING_SECURITY_LAST_EXCEPTION");
		//如果是密码不正确，记录密码错误次数
		if(exception instanceof BadCredentialsException){
			session.setAttribute("SPRING_SECURITY_LAST_EXCEPTION", new AuthenticationException("用户名或密码错误！"));
			if(securityContext != null){
				Authentication auth = securityContext.getAuthentication();
				if(auth != null){
					if(auth.getPrincipal() instanceof String){
						String username = (String)auth.getPrincipal();
						setLoginErrorTimes(username, getLoginErrorTimes(username) + 1);//登录错误次数 +1
					}else{
						logger.error("principal is not a String, its class is " + auth.getPrincipal().getClass());
					}
				}
			}
		}
	}
	
	/**
	 * 内部用户登录失败回调方法
	 */
	@RequestMapping(value="/loginfail")
	public String loginfail(HttpSession session, HttpServletRequest request,HttpServletResponse response) {  
		try{
			loginfailSettings(session,request,response);
		}catch(Exception e){
			logger.error(e);
			session.setAttribute("SPRING_SECURITY_LAST_EXCEPTION", new AuthenticationException("登录失败"));
		}
		return "redirect:/login.jsp";
	}
	
	/**
	 * 内部用户登录失败回调方法
	 */
	@RequestMapping(value="/init")
	public String init(HttpSession session, HttpServletRequest request,HttpServletResponse response) {  
		return "redirect:/login.jsp";
	}
	
	/**
	 * 外部用户登录失败回调方法
	 */
	@RequestMapping(value="/partnerloginfail")
	public String partnerloginfail(HttpSession session, HttpServletRequest request,HttpServletResponse response) {
		try{
			loginfailSettings(session,request,response);
		}catch(Exception e){
			logger.error(e);
			session.setAttribute("SPRING_SECURITY_LAST_EXCEPTION", new AuthenticationException("登录失败"));
		}
		return "redirect:/partner/login.jsp";
	}
	
	/**
	 * 添加到在线用户列表
	 * @param user 登录用户
	 * @param session
	 * @param request
	 */
	private void addOnlineEmp(User user, HttpSession session, HttpServletRequest request){
		OnlineUser onlineUser = new OnlineUser();
		onlineUser.setEmpId(user.getId());
		//onlineUser.setIpAddress(StringUtils.isNull(request.getRemoteAddr()) ? "" : request.getRemoteAddr());//客户端IP，但暂未考虑反向代理的情况
		onlineUser.setIpAddress(IpUtil.getIpAddress(request));
		onlineUser.setLoginType("WEB");//web端登录标识
		onlineUser.setSessionId(session.getId());//会话ID
		BindSession onlineSession = new BindSession(onlineUser, onlineUserService);
		session.setAttribute("online", onlineSession);
	}
	
	/**
	 * 设置某用户名的登录错误次数
	 * @param username 用户名
	 * @param errorTimes 要设置的密码错误次数
	 */
	private void setLoginErrorTimes(String username, int errorTimes) {
		Jedis jedis = RedisUtil.getJedis();
		String redisKey = "crm_loginError_info";
		username = username.toUpperCase();
		String currentdate = DateUtil.getYY_MM_DDHHmmss(new Date());
		if (jedis.exists(redisKey) && jedis.hmget(redisKey, username).size() > 0) {
			Map<String, String> map = new HashMap<String, String>();
			map.put(username, errorTimes + "+" + currentdate);
			jedis.hdel(redisKey, username);
			jedis.hmset(redisKey, map);
		}
	}

	/**
	 * 重置app用户名为username的登录错误次数为0
	 * @param username
	 * @param errorTimes
	 */
	public void resetAppLoginErrorTimes(String username) {
		Jedis jedis = RedisUtil.getJedis();
		String redisKey = "app_loginError_info";
		String currentdate = DateUtil.getYY_MM_DDHHmmss(new Date());
		Map<String, String> map = new HashMap<String, String>();
		map.put(username, 0 + "+" + currentdate);
		jedis.hdel(redisKey, username);
		jedis.hmset(redisKey, map);
	}
	
	/**
	 * 重置用户名为username的登录错误次数为0
	 * @param username
	 * @param errorTimes
	 */
	public void resetLoginErrorTimes(String username){
		setLoginErrorTimes(username, 0);
	}
	/**
	 * 获取某用户名的登录错误次数
	 * @param username 用户名
	 * @return errorTimes 规定时间内的密码错误次数
	 */
	private int getLoginErrorTimes(String username) {
		int errorTimes = 0;
		Jedis jedis = RedisUtil.getJedis();
		String redisKey = "crm_loginError_info";
		username = username.toUpperCase();
		if (jedis.exists(redisKey) && jedis.hmget(redisKey, username) != null && jedis.hmget(redisKey, username).get(0) != null) {
			errorTimes = Integer.parseInt(jedis.hmget(redisKey, username).get(0).split("\\++")[0]);
		}
		return errorTimes;
	}
	
	@RequestMapping(value="/nonSession")
	public String nonSession(HttpSession session, HttpServletRequest request,HttpServletResponse response) {  
		return "redirect:/portal/handler.jsp";
	}
	
	@RequestMapping(value="/partnerNonSession")
	public String partnerNonSession(HttpSession session, HttpServletRequest request,HttpServletResponse response) {  
		return "redirect:/partner/handler.jsp";
	}
	
	/**
	 * 访问url资源认证不通过时返回跳转到登录页的标志
	 */
	@RequestMapping(value="/accessDenied")
    public String accessDenied(HttpSession session, HttpServletRequest request,HttpServletResponse response) {
	    String result = "正在跳转到登录页...";
	    response.setContentType("text/html;charset=UTF-8");
	    response.setCharacterEncoding("UTF-8");
	    try {
            response.getWriter().print(result.toCharArray());
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }
	
	/**
	 * 
	 *<p>把用户不可访问的URL缓存到redis</p>
	 * @author yrf
	 * @param user
	 */
	private void loadUserAccessURLToRedis(User user){
		Jedis jedis = RedisUtil.getJedis();
		String redisKey = AppConstants.LINKCRM_DISABLE_ACCESS_URL_USER+user.getId();
		jedis.del(redisKey);
		
		
	}
}
