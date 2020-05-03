package com.hand.base.workbench.model;

import com.hand.base.basic.model.BasicModel;

/**
 * 商品系列
 * @author wangayn
 *
 */
public class MesPush extends BasicModel{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -5520761728352143967L;
	private String pushType;	
	private String messagePushType;		
	private String objectType;		
	private String pushText;		
	private String startTime;		    
	private String expireTime;       
	private String isPushed;
	private String activeFlag;
	private String city;
	private String cityId;
	private String code;
	private String isO2OArea;
	private String isO2ODistrict;
	private String name;
	private String parentId;
	private String parentName;
	private String objectId;
	private String userId;
	public String getPushType() {
		return pushType;
	}
	public void setPushType(String pushType) {
		this.pushType = pushType;
	}
	public String getMessagePushType() {
		return messagePushType;
	}
	public void setMessagePushType(String messagePushType) {
		this.messagePushType = messagePushType;
	}
	public String getObjectType() {
		return objectType;
	}
	public void setObjectType(String objectType) {
		this.objectType = objectType;
	}
	public String getPushText() {
		return pushText;
	}
	public void setPushText(String pushText) {
		this.pushText = pushText;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getExpireTime() {
		return expireTime;
	}
	public void setExpireTime(String expireTime) {
		this.expireTime = expireTime;
	}
	public String getIsPushed() {
		return isPushed;
	}
	public void setIsPushed(String isPushed) {
		this.isPushed = isPushed;
	}
	public String getActiveFlag() {
		return activeFlag;
	}
	public void setActiveFlag(String activeFlag) {
		this.activeFlag = activeFlag;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getCityId() {
		return cityId;
	}
	public void setCityId(String cityId) {
		this.cityId = cityId;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getIsO2OArea() {
		return isO2OArea;
	}
	public void setIsO2OArea(String isO2OArea) {
		this.isO2OArea = isO2OArea;
	}
	public String getIsO2ODistrict() {
		return isO2ODistrict;
	}
	public void setIsO2ODistrict(String isO2ODistrict) {
		this.isO2ODistrict = isO2ODistrict;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getParentId() {
		return parentId;
	}
	public void setParentId(String parentId) {
		this.parentId = parentId;
	}
	public String getParentName() {
		return parentName;
	}
	public void setParentName(String parentName) {
		this.parentName = parentName;
	}
	public String getObjectId() {
		return objectId;
	}
	public void setObjectId(String objectId) {
		this.objectId = objectId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
}
