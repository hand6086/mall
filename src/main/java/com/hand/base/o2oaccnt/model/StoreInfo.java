package com.hand.base.o2oaccnt.model;

import com.hand.base.basic.model.BasicModel;

public class StoreInfo extends BasicModel{
	private String applicantName;
	private String applicantMailBox; 
	private String applicantPhone;
	private String isThirdStore;
	private String companyName;
	public String getApplicantName() {
		return applicantName;
	}
	public void setApplicantName(String applicantName) {
		this.applicantName = applicantName;
	}
	public String getApplicantMailBox() {
		return applicantMailBox;
	}
	public void setApplicantMailBox(String applicantMailBox) {
		this.applicantMailBox = applicantMailBox;
	}
	public String getApplicantPhone() {
		return applicantPhone;
	}
	public void setApplicantPhone(String applicantPhone) {
		this.applicantPhone = applicantPhone;
	}
	public String getIsThirdStore() {
		return isThirdStore;
	}
	public void setIsThirdStore(String isThirdStore) {
		this.isThirdStore = isThirdStore;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
}
