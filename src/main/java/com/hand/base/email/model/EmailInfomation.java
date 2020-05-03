package com.hand.base.email.model;

import java.util.List;

import com.hand.base.basic.model.BasicModel;

public class EmailInfomation extends BasicModel{
	private String emailTitle;	//邮件标题
	private String emailMsg;	//邮件内容
	private String sendTime;	//发送时间
	private String emailSendAddr;	//发件地址
	private String emailSendName;	//发件地址别名
	private String emailReceiveAddr;//收件地址
	private String emailReceiveName;//收件地址别名
	private String emailCcAddr;     //抄送地址
	private String emailCcName;     //抄送地址别名
	private String emailBCcAddr;     //秘密抄送地址
	private String emailBCcName;     //秘密抄送地址别名
	private String sendedTime;		//发送完毕时间
	private String status;			//状态
	private String errorMsg;		//失败原因
	private String emailAtt;        //邮件附件
	private String innerImgSrc;     //内置图片位置
	//一个有规则的map，用作嵌入图片
	//private Map<String,String> map;
	//存放附件
	private List<String> list;
	public String getEmailTitle() {
		return emailTitle;
	}
	public String getEmailMsg() {
		return emailMsg;
	}
	public String getSendTime() {
		return sendTime;
	}
	public String getEmailSendAddr() {
		return emailSendAddr;
	}
	public String getEmailSendName() {
		return emailSendName;
	}
	public String getEmailReceiveAddr() {
		return emailReceiveAddr;
	}
	public String getEmailReceiveName() {
		return emailReceiveName;
	}
	public String getEmailCcAddr() {
		return emailCcAddr;
	}
	public String getEmailCcName() {
		return emailCcName;
	}
	public String getEmailBCcAddr() {
		return emailBCcAddr;
	}
	public String getEmailBCcName() {
		return emailBCcName;
	}
	public String getSendedTime() {
		return sendedTime;
	}
	public String getStatus() {
		return status;
	}
	public String getErrorMsg() {
		return errorMsg;
	}
	public String getEmailAtt() {
		return emailAtt;
	}
	public List<String> getList() {
		return list;
	}
	public void setEmailTitle(String emailTitle) {
		this.emailTitle = emailTitle;
	}
	public void setEmailMsg(String emailMsg) {
		this.emailMsg = emailMsg;
	}
	public void setSendTime(String sendTime) {
		this.sendTime = sendTime;
	}
	public void setEmailSendAddr(String emailSendAddr) {
		this.emailSendAddr = emailSendAddr;
	}
	public void setEmailSendName(String emailSendName) {
		this.emailSendName = emailSendName;
	}
	public void setEmailReceiveAddr(String emailReceiveAddr) {
		this.emailReceiveAddr = emailReceiveAddr;
	}
	public void setEmailReceiveName(String emailReceiveName) {
		this.emailReceiveName = emailReceiveName;
	}
	public void setEmailCcAddr(String emailCcAddr) {
		this.emailCcAddr = emailCcAddr;
	}
	public void setEmailCcName(String emailCcName) {
		this.emailCcName = emailCcName;
	}
	public void setEmailBCcAddr(String emailBCcAddr) {
		this.emailBCcAddr = emailBCcAddr;
	}
	public void setEmailBCcName(String emailBCcName) {
		this.emailBCcName = emailBCcName;
	}
	public void setSendedTime(String sendedTime) {
		this.sendedTime = sendedTime;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public void setErrorMsg(String errorMsg) {
		this.errorMsg = errorMsg;
	}
	public void setEmailAtt(String emailAtt) {
		this.emailAtt = emailAtt;
	}
	public void setList(List<String> list) {
		this.list = list;
	}
	public String getInnerImgSrc() {
		return innerImgSrc;
	}
	public void setInnerImgSrc(String innerImgSrc) {
		this.innerImgSrc = innerImgSrc;
	}
	
}
