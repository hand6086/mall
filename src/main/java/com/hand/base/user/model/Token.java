package com.hand.base.user.model;

import com.hand.base.basic.model.BasicModel;

public class Token extends BasicModel{

	private String username;           	/*用户名*/
	private String password;           	/*密码*/
	private String endDate;            	/*结束时间*/
	private String startDate;          	/*开始时间*/
	private String current;
	private String token;              	/*Token*/
	private String mdKey;
	
	private boolean isSuccess;
	private String message;
	private String code;
	
	
	public String getCurrent() {
		return current;
	}
	public void setCurrent(String current) {
		this.current = current;
	}
	public String getMdKey() {
		return mdKey;
	}
	public void setMdKey(String mdKey) {
		this.mdKey = mdKey;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public boolean isSuccess() {
		return isSuccess;
	}
	public void setSuccess(boolean isSuccess) {
		this.isSuccess = isSuccess;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}

	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getToken() {
		return token;
	}
	public void setToken(String token) {
		this.token = token;
	}



}
