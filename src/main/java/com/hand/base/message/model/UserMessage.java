package com.hand.base.message.model;

import com.hand.base.basic.model.BasicModel;

public class UserMessage extends BasicModel{

	private String userId;
	private String msgId;
	private String isRead;
	private String readTime;//阅读时间
	private String readComments;//阅读备注
	private String isMsgSend;//消息是否已发送，为'Y'
	private String userName;
	private String firstName;
	
	private String msgTitle;//消息标题
	private String msgContent;//内容
	private String msgCode;//编码
	private String importance;//重要性
	private String msgType;//类型
	private String msgReceiveType;//接收方类型
	private String isDelete;//是否已删除
	private String isSend;//是否已发送
	private String parentId;//消息父ID
	private String sendTime;//发送时间
	private String sendBy;//发送人
	private String sendById;//发送人id
	
	private String sendOrReceive;
	private String[] ids;
	
	public String[] getIds() {
		return ids;
	}
	public void setIds(String[] ids) {
		this.ids = ids;
	}
	public String getSendOrReceive() {
		return sendOrReceive;
	}
	public void setSendOrReceive(String sendOrReceive) {
		this.sendOrReceive = sendOrReceive;
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
	public String getIsDelete() {
		return isDelete;
	}
	public void setIsDelete(String isDelete) {
		this.isDelete = isDelete;
	}
	public String getIsSend() {
		return isSend;
	}
	public void setIsSend(String isSend) {
		this.isSend = isSend;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getIsMsgSend() {
		return isMsgSend;
	}
	public void setIsMsgSend(String isMsgSend) {
		this.isMsgSend = isMsgSend;
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
	public String getIsRead() {
		return isRead;
	}
	public void setIsRead(String isRead) {
		this.isRead = isRead;
	}
	public String getReadTime() {
		return readTime;
	}
	public void setReadTime(String readTime) {
		this.readTime = readTime;
	}
	public String getReadComments() {
		return readComments;
	}
	public void setReadComments(String readComments) {
		this.readComments = readComments;
	}
	public String getParentId() {
		return parentId;
	}
	public void setParentId(String parentId) {
		this.parentId = parentId;
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
	
}
