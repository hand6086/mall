package com.hand.base.common.model;

import com.hand.base.basic.model.BasicModel;

public class ScrollImg extends BasicModel {

	private String imgUrl;             	/*图片路径*/
	private String seq;                	/*顺序*/
	private String forwardUrl;         	/*点击后的跳转地址*/
	private String activeFlag;         	/*有效*/
	private String appType;            	/*系统类型*/
	private String imgId;              	/*图片ID*/
	private String imgCode;            	/*编号*/


	public String getImgUrl() {
		return imgUrl;
	}
	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}

	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}

	public String getForwardUrl() {
		return forwardUrl;
	}
	public void setForwardUrl(String forwardUrl) {
		this.forwardUrl = forwardUrl;
	}

	public String getActiveFlag() {
		return activeFlag;
	}
	public void setActiveFlag(String activeFlag) {
		this.activeFlag = activeFlag;
	}

	public String getAppType() {
		return appType;
	}
	public void setAppType(String appType) {
		this.appType = appType;
	}

	public String getImgId() {
		return imgId;
	}
	public void setImgId(String imgId) {
		this.imgId = imgId;
	}

	public String getImgCode() {
		return imgCode;
	}
	public void setImgCode(String imgCode) {
		this.imgCode = imgCode;
	}





}

