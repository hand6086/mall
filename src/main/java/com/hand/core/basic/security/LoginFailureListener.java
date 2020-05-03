package com.hand.core.basic.security;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.context.ApplicationListener;
import org.springframework.security.authentication.event.AuthenticationFailureBadCredentialsEvent;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;

import com.hand.core.util.DateUtil;
import com.hand.core.util.RedisUtil;

import redis.clients.jedis.Jedis;

@Component
public class LoginFailureListener implements ApplicationListener<AuthenticationFailureBadCredentialsEvent> {

    @Override
    public void onApplicationEvent(AuthenticationFailureBadCredentialsEvent event) {
        if (event.getException().getClass().equals(UsernameNotFoundException.class)) {
            return;
        }
        String username = event.getAuthentication().getName();
        username = username.toUpperCase();
        setLoginErrorTimes(username, getLoginErrorTimes(username) + 1);//登录错误次数 +1
    }
    
    public static void main(String[] args) {
    	LoginFailureListener LoginFailureListener =new LoginFailureListener();
    	LoginFailureListener.setLoginErrorTimes("CRM01",0);
	}
    /**
	 * 设置某用户名的登录错误次数
	 * @param username 用户名
	 * @param errorTimes 要设置的密码错误次数
	 */
	private void setLoginErrorTimes(String username, int errorTimes) {
		Jedis jedis = RedisUtil.getJedis();
		String redisKey = "crm_loginError_info";
		String currentdate = DateUtil.getYY_MM_DDHHmmss(new Date());
		if (jedis.exists(redisKey) && jedis.hmget(redisKey, username).size() > 0) {
			Map<String, String> map = new HashMap<String, String>();
			map.put(username, errorTimes + "+" + currentdate);
			jedis.hdel(redisKey, username);
			jedis.hmset(redisKey, map);
		}
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
		//username转换为大写
		username = username.toUpperCase();
		if (jedis.exists(redisKey) && jedis.hmget(redisKey, username) != null && jedis.hmget(redisKey, username).size() > 0) {
			if(jedis.hmget(redisKey, username).get(0) != null){
				errorTimes = Integer.parseInt(jedis.hmget(redisKey, username).get(0).split("\\++")[0]);
				return errorTimes;
			}
		}
		return 0;
	}
}