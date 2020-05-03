package com.hand.base.workbench.model;

import com.hand.base.basic.model.BasicModel;

/**
 * 短信发送-号码导入
 * @author wangyan
 *
 */
public class FeedBack  extends BasicModel{
	
	private String userId;			
	private String phoneNumber;	
	private String context;			
	private String type;
	private String parentId;			
	private String tAttr01;
	private String cityId;
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getPhoneNumber() {
		return phoneNumber;
	}
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	public String getContext() {
		return context;
	}
	public void setContext(String context) {
		this.context = context;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getParentId() {
		return parentId;
	}
	public void setParentId(String parentId) {
		this.parentId = parentId;
	}
	public String gettAttr01() {
		return tAttr01;
	}
	public void settAttr01(String tAttr01) {
		this.tAttr01 = tAttr01;
	}
	public String getCityId() {
		return cityId;
	}
	public void setCityId(String cityId) {
		this.cityId = cityId;
	}
	

	
}
