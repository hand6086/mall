package com.hand.base.message.model;

import com.hand.base.basic.model.BasicModel;

public class CrmMessage extends BasicModel{

	private String msgId;//消息ID
	private String msgTitle;//消息标题
	private String msgContent;//消息内容
	private String msgCode;//消息编码
	private String importance;//重要性
	private String msgType;//消息类型
	private String msgReceiveType;//消息接收类型
	private String isDelete;//是否删除
	private String isSend;//是否发送
	private String sendTime;//发送时间
	private String sendBy;//发送人
	private String sendById;//发送人ID
	private String userId;//用户ID
	private String atOriginal;//@消息原文
	
	
	
	public String getAtOriginal() {
		return atOriginal;
	}
	public void setAtOriginal(String atOriginal) {
		this.atOriginal = atOriginal;
	}
	public String getIsSend() {
		return isSend;
	}
	public void setIsSend(String isSend) {
		this.isSend = isSend;
	}
	public String getIsDelete() {
		return isDelete;
	}
	public void setIsDelete(String isDelete) {
		this.isDelete = isDelete;
	}
	public String getMsgTitle() {
		return msgTitle;
	}
	public void setMsgTitle(String msgTitle) {
		this.msgTitle = msgTitle;
	}
	public String getMsgContent() {
		return msgContent;
	}
	public void setMsgContent(String msgContent) {
		this.msgContent = msgContent;
	}
	public String getMsgCode() {
		return msgCode;
	}
	public void setMsgCode(String msgCode) {
		this.msgCode = msgCode;
	}
	public String getImportance() {
		return importance;
	}
	public void setImportance(String importance) {
		this.importance = importance;
	}
	public String getMsgType() {
		return msgType;
	}
	public void setMsgType(String msgType) {
		this.msgType = msgType;
	}
	public String getMsgReceiveType() {
		return msgReceiveType;
	}
	public void setMsgReceiveType(String msgReceiveType) {
		this.msgReceiveType = msgReceiveType;
	}
	public String getSendTime() {
		return sendTime;
	}
	public void setSendTime(String sendTime) {
		this.sendTime = sendTime;
	}
	public String getSendBy() {
		return sendBy;
	}
	public void setSendBy(String sendBy) {
		this.sendBy = sendBy;
	}
	public String getSendById() {
		return sendById;
	}
	public void setSendById(String sendById) {
		this.sendById = sendById;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getMsgId() {
		return msgId;
	}
	public void setMsgId(String msgId) {
		this.msgId = msgId;
	}
	
	
}
