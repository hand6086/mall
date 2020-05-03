package com.hand.core.basic.interceptors;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.hand.base.user.model.User;
import com.hand.base.user.service.LoginService;
import com.hand.core.util.PasswordUtil;
import com.hand.core.util.RedisUtil;
import com.hand.core.util.StringUtils;

import net.sf.json.JSONObject;
import redis.clients.jedis.Jedis;

public class MyApiInterceptor extends HandlerInterceptorAdapter implements HandlerInterceptor {

	private static final Logger logger = LogManager.getLogger(MyApiInterceptor.class);
	
	public static ThreadLocal<User> tempUser = new ThreadLocal<User>();
	
	private static final int tokenErrorCode = 220;
	//private static final int useNewTokenCode = 230;
	private static final int userErrorCode = 240;
	@Resource
	private LoginService loginService;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		logger.debug("Try Access-->"+request.getRequestURL().toString());
		String token = request.getParameter("token");
		String username = request.getParameter("username");
		String passwd = request.getParameter("passwd");
		boolean access = checkUser(response, username, passwd, token);
		if(!access) return false;
		
		User user = tempUser.get();
		logger.debug("["+user.getUsername()+"]Access-->"+request.getRequestURL().toString());
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		tempUser.remove();
	}

	/*@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		
	}*/
	
	/**
	 * 以JSON格式输出
	 * @param response
	 */
	protected boolean responseOutWithJson(HttpServletResponse response, Map<String, Object> result, int statusCode) {
		//将实体对象转换为JSON Object转换
		JSONObject responseJSONObject = JSONObject.fromObject(result);
		response.setStatus(statusCode);
		result.put("status", statusCode);
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json; charset=utf-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
			out.append(responseJSONObject.toString());
			out.flush();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (out != null) {
				out.close();
			}
		}
		return false;
	}
	
	/**
	 * 
	 *<p>调用接口用户检查</p>
	 * @author yrf
	 * @param response
	 * @param username
	 * @param passwd
	 * @param token
	 * @return
	 */
	private boolean checkUser(HttpServletResponse response, String username, String passwd, String token){
		 Map<String, Object> result = new HashMap<String, Object>();
		 User user = null;
		 
		 if(!StringUtils.isBlank(token)){
				Jedis jedis = RedisUtil.getJedis();
				String userJson = jedis.get(token);
				if(userJson != null){
					JSONObject obj = JSONObject.fromObject(userJson);
					//将json对象转换为java对象
					user = (User)JSONObject.toBean(obj,User.class);
					tempUser.set(user);
					return true;
				}
		 }
		if(StringUtils.isBlank(username) || StringUtils.isBlank(passwd) ){
			/** 没找到用户并且token 为空 */
			 if(StringUtils.isBlank(token)){
				result.put("success", false);
		   		result.put("result", "Token Can Not Be Null!");
		   		return responseOutWithJson(response, result, tokenErrorCode);
			}
			result.put("success", false);
	   		result.put("result", "用户名密码错误");
	   		return responseOutWithJson(response, result, userErrorCode);
		}
		 username = username.toUpperCase();
	   	 user = (User)loginService.loadUserByUsername(username);
	   	 
	   	 if(user != null && PasswordUtil.isEquals(passwd, user.getPassword())){
	   		 if(!StringUtils.isBlank(token)){
	   			 /** 用户对象转换为json串并保存到redis */
	   			 user.setAnonymousFlag("Y");
		   		 JSONObject userJSONObject = JSONObject.fromObject(user);
		   		 String userJson = userJSONObject.toString();
	   			Jedis jedis = RedisUtil.getJedis();
	   		 }
	   		 tempUser.set(user);
	   		return true;
	   	 }else{
	   		result.put("success", false);
	   		result.put("result", "用户名密码错误");
	   		return responseOutWithJson(response, result, userErrorCode);
	   	 }
	}
}
