package com.hand.base.message.model;

import com.hand.base.basic.model.BasicModel;

public class PushNotice extends BasicModel{

	private String pushNote;//推送内容
	private String dealDate;
	private String dealFlag;
	private String dealMessage;
	private String integrationId;
	private String userId;
	private String parameter;
	private String pushType;
	private String isRead;
	private String type;//"push" or "chat"
	private String webPushStatus;
	public String getPushNote() {
		return pushNote;
	}
	public void setPushNote(String pushNote) {
		this.pushNote = pushNote;
	}
	public String getDealDate() {
		return dealDate;
	}
	public void setDealDate(String dealDate) {
		this.dealDate = dealDate;
	}
	public String getDealFlag() {
		return dealFlag;
	}
	public void setDealFlag(String dealFlag) {
		this.dealFlag = dealFlag;
	}
	public String getDealMessage() {
		return dealMessage;
	}
	public void setDealMessage(String dealMessage) {
		this.dealMessage = dealMessage;
	}
	public String getIntegrationId() {
		return integrationId;
	}
	public void setIntegrationId(String integrationId) {
		this.integrationId = integrationId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getParameter() {
		return parameter;
	}
	public void setParameter(String parameter) {
		this.parameter = parameter;
	}
	public String getPushType() {
		return pushType;
	}
	public void setPushType(String pushType) {
		this.pushType = pushType;
	}
	public String getIsRead() {
		return isRead;
	}
	public void setIsRead(String isRead) {
		this.isRead = isRead;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getWebPushStatus() {
		return webPushStatus;
	}
	public void setWebPushStatus(String webPushStatus) {
		this.webPushStatus = webPushStatus;
	}
	
}
