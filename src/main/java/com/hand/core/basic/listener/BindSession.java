package com.hand.core.basic.listener;

import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;

import com.hand.base.user.model.OnlineUser;
import com.hand.base.user.service.OnlineUserService;
import com.hand.core.util.AppConstants;
import com.hand.core.util.RedisUtil;
import com.hand.core.util.StringUtils;

import redis.clients.jedis.Jedis;

public class BindSession implements HttpSessionBindingListener {

	private OnlineUser onlineUser;
	
	private OnlineUserService onlineUserService;

	public BindSession(OnlineUser onlineUser, OnlineUserService onlineUserService) {
		this.onlineUser = onlineUser;
		this.onlineUserService = onlineUserService;
	}

	public void valueBound(HttpSessionBindingEvent event) {
        try {
        	String sinIdEncrypt = StringUtils.encryptBySHA1(this.onlineUser.getSessionId());//加密sessionId
        	this.onlineUser.setSessionId(sinIdEncrypt);
        	this.onlineUserService.insert(this.onlineUser);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void valueUnbound(HttpSessionBindingEvent event) {
        try {
        	this.onlineUserService.deleteById(this.onlineUser);
        	
        	/** 清除用户缓存 */
        	String userId = onlineUser.getEmpId();
        	String redisKey = AppConstants.LINKCRM_DISABLE_ACCESS_URL_USER+userId;
        	Jedis jedis = RedisUtil.getJedis();
    		jedis.del(redisKey);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
