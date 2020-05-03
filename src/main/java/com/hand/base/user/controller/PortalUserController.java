package com.hand.base.user.controller;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.controller.BasicControllerException;
import com.hand.base.basic.model.BasicModel;
import com.hand.base.basic.model.ListOfValue;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.basic.service.KeyGenerateService;
import com.hand.base.user.model.User;
import com.hand.base.user.service.UserService;
import com.hand.core.basic.query.Filter;
import com.hand.core.basic.query.QueryParams;
import com.hand.core.modules.imports.ImportReader;
import com.hand.core.modules.imports.ImportsFactory;
import com.hand.core.util.PasswordUtil;
import com.hand.core.util.RedisUtil;
import com.hand.core.util.StringUtils;
import com.hand.core.util.UserUtil;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import redis.clients.jedis.Jedis;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/action/portal/user")
public class PortalUserController extends BasicController<User>{
	
	private static final Logger logger = LogManager.getLogger(PortalUserController.class);
	
	@Resource
	private UserService userService;
	@Resource
	private KeyGenerateService keyGenerateService;
	
	public BasicService<User> getBasicService(){
		return userService;
	}
	
	
	
	@RequestMapping(value="/reload")
	public String reload(HttpSession session, HttpServletRequest request,HttpServletResponse response) {  
		
		return "redirect:/portal/home.jsp";
	}
	
	@RequestMapping(value = "/queryByExamplePage")
	@ResponseBody
	public Map<String, Object> queryByExamplePage(QueryParams qps, User entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			qps.preDealSecurity(request);
			User t = (User)BasicModel.transformClass(entity, qps);
			beforQueryAllOrExample(t,request);
			beforQueryExample(t,request);
			List<User> list = new ArrayList<User>();
			if(qps.getOnlyCountFlag()){
				result.put("success", true);
				int count = userService.queryUserCount(t);
				User user = new User();
				user.setTotal(count);
				list.add(user);
				result.put("rows", list);
			}else{
				list = userService.queryByExamplePage(t);
				result.put("success", true);
				result.put("rows", list);
				this.pushCurrentDataCache(list, session.getId(), "base", false);
				result.put("total", getCount((BasicModel)t, list.size()));
			}
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<User>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 
	 *<p>根据id查询多条用户记录</p>
	 * @author yrf
	 * @param ids
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/queryByIds")
	@ResponseBody
	public Map<String, Object> queryByIds(String[] ids, HttpSession session, HttpServletRequest request,HttpServletResponse response){
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			List<User> list = new ArrayList<User>();
			Map<String, User> map = new HashMap<String, User>();
			for(String id : ids){
				if(StringUtils.isBlank(id)){
					id = "notMatchId";
				}
				User user = map.get(id);//把查询过的记录放到map里，减少重复查询
				if(user == null){
					user = new User();
					user.setId(id);
					user = userService.querySampleUserById(user);
					map.put(id, user == null ? new User() : user);
				}
				list.add(map.get(id));
			}
			result.put("success", true);
			result.put("result", list);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 
	 *<p>分页查询内部用户</p>
	 * @author yrf
	 * @param user
	 * @param qps
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/list/INTER_EMP", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> listInner(User user, QueryParams qps, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		String userType = "INTER_EMP";
		qps.preDealSecurity(request);
		qps.addFilter(new Filter("empTypeLovType", userType));
		user.setEmpTypeLovType(userType);
		// qps.addSorter(new Sorter("id", Sorter.DIR_ASC));
		return this.queryByExamplePage(qps, user, session, request, response);
	}
	/**
	 * 
	 *<p>分页查询外部用户</p>
	 * @author yrf
	 * @param qps
	 * @param user
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/list/OUTER_EMP", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> listOuter(QueryParams qps, User user, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		String userType = "OUTER_EMP";
		user.setEmpTypeLovType(userType);
		qps.addFilter(new Filter("empTypeLovType", userType));
		return this.queryByExamplePage(qps, user, session, request, response);
	}
	
	
	/**
	 * 
	 *<p>导出外部用户</p>
	 * @author yrf
	 * @param user
	 * @param qps
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/list/OUTER_EMP/exportData")
	@ResponseBody
	public Map<String, Object> listOuterExport(User user, QueryParams qps,HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		logger.info("导出外部用户列表...");
		
		String userType = "OUTER_EMP";
		qps.addFilter(new Filter("empTypeLovType", userType));
		user.setEmpTypeLovType(userType);
		return this.exportData(user, qps, session, request, response);
	}
	
	/**
	 * 
	 *<p>导出内部用户</p>
	 * @author yrf
	 * @param user
	 * @param qps
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/list/INTER_EMP/exportData")
	@ResponseBody
	public Map<String, Object> listInterExport(User user, QueryParams qps, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		logger.info("导出内部用户列表...");
		String userType = "INTER_EMP";
		qps.addFilter(new Filter("empTypeLovType", userType));
		user.setEmpTypeLovType(userType);
		return this.exportData(user, qps, session, request, response);
	}
	
	@RequestMapping(value = "/list/OUTER_EMP/importData")
	@ResponseBody
	public Map<String, Object> listOuterImport(HttpSession session,QueryParams qps,
			HttpServletRequest request, HttpServletResponse response) {
		logger.info("导入外部用户列表...");
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			ImportReader importReader= ImportsFactory.newInstance(qps,request);
			List<User> list = importReader.readList(User.class);
			for(int i =0;list != null && i<list.size() ;i++){
				User record = list.get(i);			
				User checkUser = userService.getUserByUsername(record.getUsername());
				if(checkUser != null){
					result.put("success", false);
					result.put("result", "用户名：" + record.getUsername() + "已存在，不能重复创建！");
					return result;
				}			
				if(record.getStatus().equals("")){
					record.setStatus("正常");
				}
				if(record.getCorpid().equals("")){
					User user1 = UserUtil.getUser(null);				
					record.setCorpid(user1.getCorpid());
				}			
				record.setId(keyGenerateService.keyGenerate());
				userService.insert(record);
			}
			result.put("success", true);
			result.put("total", list.size());
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	@RequestMapping(value = "/list/INTER_EMP/importData")
	@ResponseBody
	public Map<String, Object> listInterImport(HttpSession session,QueryParams qps,
			HttpServletRequest request, HttpServletResponse response) {
		logger.info("导入内部用户列表...");
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			ImportReader importReader= ImportsFactory.newInstance(qps,request);
			List<User> list = importReader.readList(User.class);
			for(int i =0;list != null && i<list.size() ;i++){
				User record = list.get(i);			
				User checkUser = userService.getUserByUsername(record.getUsername());
				if(checkUser != null){
					result.put("success", false);
					result.put("result", "用户名：" + record.getUsername() + "已存在，不能重复创建！");
					return result;
				}			
				if(record.getStatus().equals("")){
					record.setStatus("正常");
				}
				if(record.getCorpid().equals("")){
					User user1 = UserUtil.getUser(null);				
					record.setCorpid(user1.getCorpid());
				}			
				record.setId(keyGenerateService.keyGenerate());
				userService.insert(record);
			}
			result.put("success", true);
			result.put("total", list.size());
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 
	 *<p>外部用户新建默认值</p>
	 * @author yrf
	 * @return
	 */
	@RequestMapping(value = "/list/OUTER_EMP/preDefaultValue")
	@ResponseBody
	public Map<String, Object> preDefaultValue(){
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			User outerUser = userService.outerPreDefaultValue();
			result.put("success", true);
			result.put("result", outerUser);
		}catch(Exception e){
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	public void beforInsert(User record, HttpServletRequest request) throws Exception{
		User checkUser = userService.getUserByUsername(record.getUsername());
		if(checkUser != null){
			throw new BasicControllerException("用户名：" + record.getUsername() + "已存在，不能重复创建！");
		}
		if("".equals(record.getStatus())){
			record.setStatus("正常");
		}
		if("".equals(record.getCorpid())){
			
			User user1 = UserUtil.getUser(null);
			
			record.setCorpid(user1.getCorpid());
		}
	}
	public void beforUpsert(User record, HttpServletRequest request) throws Exception{
		if(userService.isInsertFlag(record)){
			beforInsert(record, request);
		}else{
			beforUpdate(record, request);
		}
	}
	
	public void beforUpdate(User record, HttpServletRequest request) throws Exception{
		User checkUser = userService.getUserByUsername(record.getUsername());
		if(checkUser != null ){
			String selectId = record.getId();
			String recordId = checkUser.getId();
			if(!selectId.equals(recordId)){
				throw new BasicControllerException("用户名：" + record.getUsername() + "已存在，不能重复创建！");
			}
		}
	}
	
	/**
	 * 
	 *<p>生成密码，默认联系电话后六位</p>
	 * @author yrf
	 * @param record
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/genPsw", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updatePostn(User record, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		User user = new User();
		user.setId(record.getId());
		try{
			user = userService.queryById(user);
			/*if(!StringUtils.isBlank(user.getPassword())){
				result.put("success", false);
				result.put("result", "该用户已有密码，不可重新生成密码");
				return result;
			}*/
			String password = user.getContactPhone();
			if(password == null || password.length() <6){
				result.put("success", false);
				result.put("result", "联系号码错误");
				return result;
			}
			password = password.substring(password.length()-6, password.length());
			userService.resetPassword(user, password, password);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value = "/resetPassword", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> resetPassword(User record, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		Jedis jedis = null;
		try{
			jedis = RedisUtil.getJedis();

			String password = record.getPassword();
			String userName = record.getUsername();
			String phone = record.getContactPhone();
			String userKey = "reset_pwd_user_" + userName;
			String userInfo = userName.toUpperCase() + phone;
			String codeKey = "verify_code_" + phone;
			// 校验用户一致性（用户名+手机号）
			if (StringUtils.isBlank(jedis.get(userKey))){
				throw new BasicServiceException("用户信息前后不一致！");
			} else if (!userInfo.equals(jedis.get(userKey))) {
				throw new BasicServiceException("用户信息前后不一致！");
			}
			// 校验验证码
			if (StringUtils.isBlank(jedis.get(codeKey))) {
				throw new BasicServiceException("验证码校验错误！");
			}else if (!"SUCCESS".equals(jedis.get(codeKey))){
				throw new BasicServiceException("验证码校验错误！");
			}
			User user = userService.getUserByUsername(userName);
			if (user != null) {
				userService.resetPassword(user, password, password);
				// 密码修改完成之后，清除相关redis信息
				jedis.del(codeKey);
				jedis.del(userKey);
				result.put("success", true);
			}else{
				throw new BasicServiceException("用户不存在!");
			}
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}finally {
			RedisUtil.returnResource(jedis);
		}
		return result;
	}

	/**
	 * 用户名和手机号校验（用于重置密码）
	 * @author anxiaobo
	 * @date 2019/04/22 11:05
	 * @param session
	 * @param request
	 * @param response
	 * @return 校验结果
	 */
	@RequestMapping(value = "/checkUserInfo", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> checkUserInfo(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		String phone = request.getParameter("contactPhone");
		String userName = request.getParameter("username");
		if (StringUtils.isBlank(phone) || StringUtils.isBlank(userName)) {
			throw new BasicServiceException("手机号或用户名为空！");
		}
		Jedis jedis = null;
		try {
			User user = userService.getUserByPhone(phone);
			if (user != null) {
				if (!userName.toUpperCase().equals(user.getUsername().toUpperCase())) {
					result.put("success", false);
					result.put("result", "该手机号与用户名不匹配!");
				} else {
					// 将用户信息校验结果存入redis
					jedis = RedisUtil.getJedis();
					String redisKey = "reset_pwd_user_" + userName;
					String value = user.getUsername().toUpperCase() + user.getContactPhone();
					jedis.set(redisKey, value);
					// 设置有效时间10分钟
					jedis.expire(redisKey, 600);

					result.put("success", true);
					result.put("result", "用户信息校验通过!");
				}

			} else {
				result.put("success", false);
				result.put("result", "该手机号未绑定用户!");
			}
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}finally {
			RedisUtil.returnResource(jedis);
		}
		return result;
	}

	/**
	 * 更新DMS
	 */
	@RequestMapping(value = "/updateDmsProfile")
	@ResponseBody
	public Map<String, Object> updateProfile(User entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			beforUpdate(entity, request);
			beforUpsert(entity, request);
			checkData(entity, request);
			if(!checkExistDataCache("base", session, entity)){
				throw new BasicServiceException("非法更新数据！");
			}
			userService.updateDmsProfile(entity);	

			auditTrailInsert(entity,request,session,"U");    //审计追踪新建记录
			
			User newEntry = userService.queryById(entity);
			session.setAttribute("UserContext", newEntry);
			result.put("newRow", newEntry);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/*
	 * 获取年月
	 */
	@RequestMapping(value = "/list/{type}")
	@ResponseBody
	public Object list(@PathVariable String type, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		List<ListOfValue> list = new ArrayList<ListOfValue>();
		try{
			SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy年MM月");
			SimpleDateFormat sdf2 = new SimpleDateFormat("yyyyMM");
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.MONTH, -2);
			for(int i = 0; i < 3; i++){
				cal.add(Calendar.MONTH, 1);
				Date date = cal.getTime();
				String date1 = sdf1.format(date);
				String date2 = sdf2.format(date);
				ListOfValue record = new ListOfValue();
	        	record.setType(type);
	        	record.setName(date1);
	        	record.setVal(date2);
				list.add(record);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return list;
	}

	@RequestMapping(value = "/listOfVal/{type}")
	@ResponseBody
	public Map<String, Object> listOfValTypes(@PathVariable String type, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		List<ListOfValue> list = new ArrayList<ListOfValue>();
		try{
			SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy年MM月");
			SimpleDateFormat sdf2 = new SimpleDateFormat("yyyyMM");
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.MONTH, -2);
			for(int i = 0; i < 3; i++){
				cal.add(Calendar.MONTH, 1);
				Date date = cal.getTime();
				String date1 = sdf1.format(date);
				String date2 = sdf2.format(date);
				ListOfValue record = new ListOfValue();
	        	record.setType(type);
	        	record.setName(date1);
	        	record.setVal(date2);
				list.add(record);
			}
			result.put("success", true); 
			result.put("rows", list);
			result.put("total", list.size());
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<ListOfValue>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value="/test")  
    @ResponseBody  
    public String getSessionId(HttpServletRequest request){  
          
        Object o = request.getSession().getAttribute("springboot");  
        if(o == null){  
            o = request.getLocalPort();  
            request.getSession().setAttribute("springboot", o);  
        }  
          
        return "请求端口=" + request.getLocalPort() +  " sessionId=" + request.getSession().getId() + " 存储值=" + request.getSession().getAttribute("springboot")  +"<br/>"+o;  
    }
	
	@RequestMapping(value="/sessions")  
    @ResponseBody  
    public String sessions(HttpServletRequest request){  
          
        Object o = request.getSession().getAttribute("springboot");  
        if(o == null){  
            o = request.getLocalPort();  
            request.getSession().setAttribute("springboot", o);  
        }  
          
        return "请求端口=" + request.getLocalPort() +  " sessionId=" + request.getSession().getId() + " 存储值=" + request.getSession().getAttribute("springboot")  +"<br/>"+o;  
    }
	
	/**
	 * 
	 *<p>生成密码，默认联系电话后六位</p>
	 * @author yrf
	 * @param record
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/resetErrorTimes", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> resetErrorTimes(User record, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		User user = new User();
		LoginController loginController = new LoginController();
		user.setId(record.getId());
		try{
			user = userService.queryById(user);
			//重置登录失败次数为0
			loginController.resetLoginErrorTimes(user.getUsername());
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 
	 *校验用户密码是否正确
	 * @author yrf
	 * @param record
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/checkPassword", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> checkPassword(String password) {
		Map<String, Object> result = new HashMap<String, Object>();
		User user = UserUtil.getUser(null);
		try{
			password = PasswordUtil.generatePwd(password);
			user = userService.queryById(user);
			if(password != null && !"".equals(password) && password.equals(user.getPassword())){
				result.put("success", true);
			}else{
				result.put("success", false);
				result.put("result", "密码错误");
			}
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
}
