package com.hand.base.batchrelease.model;

import com.hand.base.basic.model.BasicModel;
import com.hand.base.user.model.User;
import com.hand.core.util.UserUtil;

public class BatchRelease extends BasicModel{
	private String checkStatus;
	private String importStatus;
	private String errorMessage;
	private String couponCode;
	private String telephoneNumber;
	private String orgId;

	public String getOrgId() {
		User user = UserUtil.getUser(null);
		orgId = user.getOrgId();
		return orgId;
	}

	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}
	public String getCheckStatus() {
		return checkStatus;
	}
	public void setCheckStatus(String checkStatus) {
		this.checkStatus = checkStatus;
	}
	public String getImportStatus() {
		return importStatus;
	}
	public void setImportStatus(String importStatus) {
		this.importStatus = importStatus;
	}
	public String getErrorMessage() {
		return errorMessage;
	}
	public void setErrorMessage(String errorMessage) {
		this.errorMessage = errorMessage;
	}
	public String getCouponCode() {
		return couponCode;
	}
	public void setCouponCode(String couponCode) {
		this.couponCode = couponCode;
	}
	public String getTelephoneNumber() {
		return telephoneNumber;
	}
	public void setTelephoneNumber(String telephoneNumber) {
		this.telephoneNumber = telephoneNumber;
	}
	

	
	
}