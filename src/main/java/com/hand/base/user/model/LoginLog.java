package com.hand.base.user.model;

import com.hand.base.basic.model.BasicModel;

public class LoginLog extends BasicModel{
	
	private String ipAddress;//ip地址
	private String userAgent;//用户浏览器
	private String userId;//用户ID
	private String loginName;//登录名字
	private String loginTime;//登录时间
	private String sessionId;//会话Id
	private String userSource;//portal，Pad标志，用来区分是portal登录，还是pad登录
	private Character lockFlag;//锁定标识.登陆失败用
	private String firstName;
	
	
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getIpAddress() {
		return ipAddress;
	}
	public void setIpAddress(String ipAddress) {
		this.ipAddress = ipAddress;
	}
	public String getUserAgent() {
		return userAgent;
	}
	public void setUserAgent(String userAgent) {
		this.userAgent = userAgent;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getLoginName() {
		return loginName;
	}
	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}
	public String getLoginTime() {
		return loginTime;
	}
	public void setLoginTime(String loginTime) {
		this.loginTime = loginTime;
	}
	public String getSessionId() {
		return sessionId;
	}
	public void setSessionId(String sessionId) {
		this.sessionId = sessionId;
	}
	public String getUserSource() {
		return userSource;
	}
	public void setUserSource(String userSource) {
		this.userSource = userSource;
	}
	public Character getLockFlag() {
		return lockFlag;
	}
	public void setLockFlag(Character lockFlag) {
		this.lockFlag = lockFlag;
	}
	
}
