package com.hand.core.basic.interceptors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.HandlerMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.hand.base.user.model.User;
import com.hand.core.util.AppConstants;
import com.hand.core.util.RedisUtil;
import com.hand.core.util.UserUtil;

import redis.clients.jedis.Jedis;

public class MyInterceptor extends HandlerInterceptorAdapter implements HandlerInterceptor {

	private static final Logger logger = LogManager.getLogger(MyInterceptor.class);
	
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		logger.debug("Try Access-->"+request.getRequestURL().toString());
		String pattern = (String) request.getAttribute(HandlerMapping.BEST_MATCHING_PATTERN_ATTRIBUTE);
		User user = UserUtil.getUser(null);
		if(user == null){
			response.sendError(401, "Unauthorized");
			return false;
		}
		String userId = user.getId();
		Jedis jedis = RedisUtil.getJedis();
		String accessFlag = jedis.hget(AppConstants.LINKCRM_DISABLE_ACCESS_URL_USER+userId, pattern);
		if("N".equals(accessFlag)){
			response.sendError(403, "Forbidden access");
			return false;
		}
		String flag = jedis.hget(AppConstants.LINKCRM_RESTRICT_ACCESS_URL, pattern);
		if(flag == null){
			//为空说明是默认可访问的url
			return true;
		}else{
			return true;
		}
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
	}

	/*@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		
	}*/
}
