package com.hand.core.util;

import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;

import com.hand.base.user.model.User;
import com.hand.core.basic.interceptors.MyApiInterceptor;


public class UserUtil {
	private static final Logger logger = LogManager.getLogger(UserUtil.class);
	
	public static User getUser(HttpSession session) {
		User user = null;
		try {
			//user = MyApiInterceptor.tempUser.get();
			//if(user != null){
			//	return user;
			//}
			SecurityContext securityContext = null;
			if(session != null){
				securityContext = (SecurityContext)  session
						.getAttribute("SPRING_SECURITY_CONTEXT");
			}else{
				securityContext = SecurityContextHolder.getContext();
			}
			if(securityContext == null){
				logger.debug("获取不到登录用户信息，可能是用户未登录或者Session过期");
				return null;
			}
			Authentication auth = securityContext.getAuthentication();
			
			if (auth == null) {
				logger.debug("获取不到登录用户信息");
				return null;
			}
			user = (User) auth.getPrincipal();
		} catch (Exception e) {
			logger.error("获取登录用户失败", e);
			throw new RuntimeException(e);
		}

		return user;
	}
}
