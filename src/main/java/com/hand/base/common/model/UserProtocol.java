package com.hand.base.common.model;

import com.hand.base.basic.model.BasicModel;

public class UserProtocol extends BasicModel {

	private String loginName;
	private String status;
	private String versionNum;
	public String getLoginName() {
		return loginName;
	}
	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getVersionNum() {
		return versionNum;
	}
	public void setVersionNum(String versionNum) {
		this.versionNum = versionNum;
	}
	
}
