package com.hand.base.enterprise.model;

import com.hand.base.basic.model.BasicModel;

public class BankCard extends BasicModel {

	/**
	 * 添加修改查询银行卡
	 */
	private static final long serialVersionUID = 5764555148636543400L;
	private String contact; //联系人
	private String contactPhone; //预留手机号
	private String o2oAccntName;//开户人
	private String bank; //开户银行
	private String creaitCard; //银行卡号
	public String getContact() {
		return contact;
	}
	public void setContact(String contact) {
		this.contact = contact;
	}
	public String getContactPhone() {
		return contactPhone;
	}
	public void setContactPhone(String contactPhone) {
		this.contactPhone = contactPhone;
	}
	public String getO2oAccntName() {
		return o2oAccntName;
	}
	public void setO2oAccntName(String o2oAccntName) {
		this.o2oAccntName = o2oAccntName;
	}
	public String getBank() {
		return bank;
	}
	public void setBank(String bank) {
		this.bank = bank;
	}
	public String getCreaitCard() {
		return creaitCard;
	}
	public void setCreaitCard(String creaitCard) {
		this.creaitCard = creaitCard;
	}
	
	
}
