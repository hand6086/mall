package com.hand.base.order.model;

import com.hand.base.basic.model.BasicModel;

public class OrderDelivery extends BasicModel {

	private String orderNumber;// 订单编号（主键）
	private String shippingAddress;// 收货地址
	private String logisticsCompany;// 物流公司
	private String logisticsOddNumber;// 物流单号
	private String shippingTime;// 发运时间
	private String checkStatus;// 校验状态
	private String errorMessage;// 校验结果
	private String attrib48;// 
	private String attrib07;//
	private String[] ordnumArray;
	public String getOrderNumber() {
		return orderNumber;
	}
	public void setOrderNumber(String orderNumber) {
		this.orderNumber = orderNumber;
	}
	public String getShippingAddress() {
		return shippingAddress;
	}
	public void setShippingAddress(String shippingAddress) {
		this.shippingAddress = shippingAddress;
	}
	public String getLogisticsCompany() {
		return logisticsCompany;
	}
	public void setLogisticsCompany(String logisticsCompany) {
		this.logisticsCompany = logisticsCompany;
	}
	public String getLogisticsOddNumber() {
		return logisticsOddNumber;
	}
	public void setLogisticsOddNumber(String logisticsOddNumber) {
		this.logisticsOddNumber = logisticsOddNumber;
	}
	public String getShippingTime() {
		return shippingTime;
	}
	public void setShippingTime(String shippingTime) {
		this.shippingTime = shippingTime;
	}
	public String getCheckStatus() {
		return checkStatus;
	}
	public void setCheckStatus(String checkStatus) {
		this.checkStatus = checkStatus;
	}
	public String getErrorMessage() {
		return errorMessage;
	}
	public void setErrorMessage(String errorMessage) {
		this.errorMessage = errorMessage;
	}
	public String getAttrib48() {
		return attrib48;
	}
	public void setAttrib48(String attrib48) {
		this.attrib48 = attrib48;
	}
	public String getAttrib07() {
		return attrib07;
	}
	public void setAttrib07(String attrib07) {
		this.attrib07 = attrib07;
	}
	public String[] getOrdnumArray() {
		return ordnumArray;
	}
	public void setOrdnumArray(String[] ordnumArray) {
		this.ordnumArray = ordnumArray;
	}

}
