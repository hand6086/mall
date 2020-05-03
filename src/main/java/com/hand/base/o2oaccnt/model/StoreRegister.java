package com.hand.base.o2oaccnt.model;

import com.hand.base.basic.model.BasicModel;

public class StoreRegister extends BasicModel{
	private String id; //用户id
	private String created;
	private String createdBy;
	private String lastupdate;
	private String lastupdateBy;
	private String corpid;
	private String username; 
	private String password;
	private String phonenumber;
	private String storeStatus; //商户状态
	
	
	
	
	public String getStoreStatus() {
		return storeStatus;
	}
	public void setStoreStatus(String storeStatus) {
		this.storeStatus = storeStatus;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getCreated() {
		return created;
	}
	public void setCreated(String created) {
		this.created = created;
	}
	public String getCreatedBy() {
		return createdBy;
	}
	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
	}
	public String getLastupdate() {
		return lastupdate;
	}
	public void setLastupdate(String lastupdate) {
		this.lastupdate = lastupdate;
	}
	public String getLastupdateBy() {
		return lastupdateBy;
	}
	public void setLastupdateBy(String lastupdateBy) {
		this.lastupdateBy = lastupdateBy;
	}
	public String getCorpid() {
		return corpid;
	}
	public void setCorpid(String corpid) {
		this.corpid = corpid;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getPhonenumber() {
		return phonenumber;
	}
	public void setPhonenumber(String phonenumber) {
		this.phonenumber = phonenumber;
	}
}
