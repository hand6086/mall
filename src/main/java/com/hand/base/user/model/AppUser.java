package com.hand.base.user.model;

import com.hand.base.basic.model.BasicModel;

public class AppUser extends BasicModel{

	
	/**
	 * App用户
	 */
	private static final long serialVersionUID = 3287499831030215552L;

	private String name;//姓名
	private String userType;//用户类型
	private String phoneNumber;//电话号码
	private String password;//密码
	private String status;//是否有效
	private String customerId;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getUserType() {
		return userType;
	}
	public void setUserType(String userType) {
		this.userType = userType;
	}
	public String getPhoneNumber() {
		return phoneNumber;
	}
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getCustomerId() {
		return customerId;
	}
	public void setCustomerId(String customerId) {
		this.customerId = customerId;
	}
	
	
}
