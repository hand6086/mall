package com.hand.base.common.model;

import com.hand.base.basic.model.BasicModel;

public class Msg extends BasicModel{
	
	private String id;
	
	private String title;
	
	private String type;
	
	private String msgContent;
	
	private byte[] msgContents;
	
	private String beginTime;
	
	

	public String getBeginTime() {
		return beginTime;
	}

	public void setBeginTime(String beginTime) {
		this.beginTime = beginTime;
	}

	private String isAllValid;
	
	private String isPublished;
	
	private String isRead;
	
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getMsgContent() {
		return msgContent;
	}

	public void setMsgContent(String msgContent) {
		this.msgContent = msgContent;
	}

	public byte[] getMsgContents() {
		return msgContents;
	}

	public void setMsgContents(byte[] msgContents) {
		this.msgContents = msgContents;
	}

	


	public String getIsAllValid() {
		return isAllValid;
	}

	public void setIsAllValid(String isAllValid) {
		this.isAllValid = isAllValid;
	}

	public String getIsPublished() {
		return isPublished;
	}

	public void setIsPublished(String isPublished) {
		this.isPublished = isPublished;
	}

	public String getIsRead() {
		return isRead;
	}

	public void setIsRead(String isRead) {
		this.isRead = isRead;
	}
}
