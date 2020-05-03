package com.hand.base.email.model;

import com.hand.base.basic.model.BasicModel;

/**
 * Email 收件人信息
 * @author ashen
 *
 */
public class EmailItem extends BasicModel{
	private String contactId;		//联系人Id
	private String emailId;			//Emial头Id
	private String emailSendAddr;	//发件地址
	private String emailSendName;	//发件地址别名
	private String emailReceiveAddr;//收件地址
	private String emailReceiveName;//收件地址别名
	private String sendedTime;		//发送完毕时间
	private String status;			//状态
	private String errorMsg;		//失败原因
	
	public String getContactId() {
		return contactId;
	}
	public void setContactId(String contactId) {
		this.contactId = contactId;
	}
	public String getEmailSendAddr() {
		return emailSendAddr;
	}
	public void setEmailSendAddr(String emailSendAddr) {
		this.emailSendAddr = emailSendAddr;
	}
	public String getEmailSendName() {
		return emailSendName;
	}
	public void setEmailSendName(String emailSendName) {
		this.emailSendName = emailSendName;
	}
	public String getEmailReceiveAddr() {
		return emailReceiveAddr;
	}
	public void setEmailReceiveAddr(String emailReceiveAddr) {
		this.emailReceiveAddr = emailReceiveAddr;
	}
	public String getEmailReceiveName() {
		return emailReceiveName;
	}
	public void setEmailReceiveName(String emailReceiveName) {
		this.emailReceiveName = emailReceiveName;
	}
	public String getSendedTime() {
		return sendedTime;
	}
	public void setSendedTime(String sendedTime) {
		this.sendedTime = sendedTime;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getEmailId() {
		return emailId;
	}
	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}
	public String getErrorMsg() {
		return errorMsg;
	}
	public void setErrorMsg(String errorMsg) {
		this.errorMsg = errorMsg;
	}
	
}
