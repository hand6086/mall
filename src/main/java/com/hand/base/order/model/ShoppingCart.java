package com.hand.base.order.model;

import com.hand.base.basic.model.BasicModel;

public class ShoppingCart extends BasicModel {
	/**
	 * 购物车
	 */
	private static final long serialVersionUID = -7747858761614759914L;
	private String name;// 城市 //created 日期
	private String customerName;// 消费者名称
	private String ouNum;// 消费者编码
	private String o2oDisplayName;// 商品名称
	private String o2oIntCode;// 商品编码
	private String qty;// 数量
	private String status; // 状态

	private String mainPhNum;// 手机号

	// 与插入相关的picklist字段
	private String tAttr01;
	private String customerId;
	private String merchId;
	
	
	private String channelType;//频道标识
	private String scenesType;//场景标识
	private String promotionType;//促销标识
	
	
	private String cityId;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public String getOuNum() {
		return ouNum;
	}

	public void setOuNum(String ouNum) {
		this.ouNum = ouNum;
	}

	public String getO2oDisplayName() {
		return o2oDisplayName;
	}

	public void setO2oDisplayName(String o2oDisplayName) {
		this.o2oDisplayName = o2oDisplayName;
	}

	public String getO2oIntCode() {
		return o2oIntCode;
	}

	public void setO2oIntCode(String o2oIntCode) {
		this.o2oIntCode = o2oIntCode;
	}

	public String getQty() {
		if (qty != null && qty.indexOf(".") > 0) {
			return qty.substring(0, qty.indexOf("."));
		}
		return qty;
	}

	public void setQty(String qty) {
		this.qty = qty;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getMainPhNum() {
		return mainPhNum;
	}

	public void setMainPhNum(String mainPhNum) {
		this.mainPhNum = mainPhNum;
	}

	public String gettAttr01() {
		return tAttr01;
	}

	public void settAttr01(String tAttr01) {
		this.tAttr01 = tAttr01;
	}

	public String getCustomerId() {
		return customerId;
	}

	public void setCustomerId(String customerId) {
		this.customerId = customerId;
	}

	public String getMerchId() {
		return merchId;
	}

	public void setMerchId(String merchId) {
		this.merchId = merchId;
	}

	public String getChannelType() {
		return channelType;
	}

	public void setChannelType(String channelType) {
		this.channelType = channelType;
	}

	public String getScenesType() {
		return scenesType;
	}

	public void setScenesType(String scenesType) {
		this.scenesType = scenesType;
	}

	public String getPromotionType() {
		return promotionType;
	}

	public void setPromotionType(String promotionType) {
		this.promotionType = promotionType;
	}

	public String getCityId() {
		return cityId;
	}

	public void setCityId(String cityId) {
		this.cityId = cityId;
	}

}
