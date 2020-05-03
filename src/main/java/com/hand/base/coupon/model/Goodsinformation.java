package com.hand.base.coupon.model;

import com.hand.base.basic.model.BasicModel;

public class Goodsinformation extends BasicModel{
	/**
	 * 
	 */
	private static final long serialVersionUID = -7904984481835308484L;
	private String merchName;
	private String merchCode;
	private String	promotionCodeId;
	private String merchId;

	
	public String getMerchName() {
		return merchName;
	}
	public void setMerchName(String merchName) {
		this.merchName = merchName;
	}
	public String getMerchCode() {
		return merchCode;
	}
	public void setMerchCode(String merchCode) {
		this.merchCode = merchCode;
	}

	public String getPromotionCodeId() {
		return promotionCodeId;
	}
	public void setPromotionCodeId(String promotionCodeId) {
		this.promotionCodeId = promotionCodeId;
	}
	public String getMerchId() {
		return merchId;
	}
	public void setMerchId(String merchId) {
		this.merchId = merchId;
	}
	
	
}