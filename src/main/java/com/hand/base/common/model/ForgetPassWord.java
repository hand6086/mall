package com.hand.base.common.model;

import com.hand.base.basic.model.BasicModel;
	
public class ForgetPassWord extends BasicModel {
	private String userName;//用户名
	private String userId;//用户ID
	private String validateCode;//验证码
	private String userEmail;//用户邮箱
	private String emailCode;//邮箱验证码
	private String emailSendDt;//邮箱验证码发送时间
	public String getUserName() {
		return userName;
	}
	public String getUserId() {
		return userId;
	}
	public String getValidateCode() {
		return validateCode;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public String getEmailCode() {
		return emailCode;
	}
	public String getEmailSendDt() {
		return emailSendDt;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public void setValidateCode(String validateCode) {
		this.validateCode = validateCode;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public void setEmailCode(String emailCode) {
		this.emailCode = emailCode;
	}
	public void setEmailSendDt(String emailSendDt) {
		this.emailSendDt = emailSendDt;
	}
}
