package com.hand.base.email.model;

import com.hand.base.basic.model.BasicModel;

public class EmailInfo extends BasicModel{
	private String emailMsg;	//邮件内容
	private String emailTitle;	//邮件标题
	private String sendTime;	//发送时间
	private String status;		//状态
	
	public String getEmailMsg() {
		return emailMsg;
	}
	public void setEmailMsg(String emailMsg) {
		this.emailMsg = emailMsg;
	}
	public String getEmailTitle() {
		return emailTitle;
	}
	public void setEmailTitle(String emailTitle) {
		this.emailTitle = emailTitle;
	}
	public String getSendTime() {
		return sendTime;
	}
	public void setSendTime(String sendTime) {
		this.sendTime = sendTime;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
}
