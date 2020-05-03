package com.hand.base.user.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hand.base.user.model.User;
import com.hand.base.user.service.UserService;

@Controller
@RequestMapping("/base/user")
public class UserController {
	private static final Logger logger = LogManager.getLogger(UserController.class);
	
	@Resource
	private UserService userService;
	
	@RequestMapping(value="/login")
	public ModelAndView login(HttpSession session, HttpServletRequest request,HttpServletResponse response) {  
		ModelAndView mav = new ModelAndView();
		try {
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
			session.setAttribute("UserContext", user);
			mav.setViewName("portal/home");
		} catch (Exception e) {
			logger.error("获取登录用户失败", e);
			mav.setViewName("index");
		}
		return mav;
	}
	
	@RequestMapping(value="/loginfail")
	public ModelAndView loginfail(HttpSession session, HttpServletRequest request,HttpServletResponse response) {  
		ModelAndView mav = new ModelAndView();
		mav.setViewName("index");
		return mav;
	}
	
	@RequestMapping(value="/nonSession")
	public ModelAndView nonSession(HttpSession session, HttpServletRequest request,HttpServletResponse response) {  
		//设置返回状态码为220
		ModelAndView mav = new ModelAndView();
		mav.setViewName("error/PermissionNotEnough");
		response.setStatus(220);
		return mav;
	}
	
	/*private void loginlog(User user,HttpSession session, HttpServletRequest request, HttpServletResponse respone) {
		try {
			//记录登录日志
			String remoteIp = request.getRemoteAddr();
			com.hand.mobile.system.model.LoginLog loginLog = new LoginLog();
			loginLog.setUserId(user.getId());
			loginLog.setUserName(user.getLogin());
			loginLog.setLoginTime(new Date());
			loginLog.setLogoutTime(new Date());
			loginLog.setSessionId(session.getId());
			loginLog.setIpAddress(remoteIp);
			loginLog.setLastUPD(new Date());
			loginLogService.create(loginLog);
		} catch (Exception e) {
			logger.error("登陆日志信息记录失败", e);
		}
	
	}
	*/
	
}
