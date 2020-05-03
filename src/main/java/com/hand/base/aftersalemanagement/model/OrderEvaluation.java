package com.hand.base.aftersalemanagement.model;

import com.hand.base.basic.model.BasicModel;

public class OrderEvaluation extends BasicModel {
	/**
	 * 
	 */
	private static final long serialVersionUID = 4043615450659647216L;
	private String 	orderRate;	//订单评级
	private String 	context	;//具体评价内容
	private String 	isPositive;	//是否正面评价
	private String 	orderCreated;	
	private String 	type;	//类型;
	private String 	orderNumber	;//订单编号
	private String 	productName;//商品名称
	private String 	productCode;//商品编码
	private String 	merchRate;//商品评级
	private String 	customerName;	//消费者名称
	private String 	customerCode	;//消费者编码
	private String 	customerPhoneNumber	;//消费者电话
	private String 	receiverName;	//收货人
	private String 	receiverPhone	;//电话
	private String 	receiverProvince;	//省/直辖市
	private String 	receiverCity	;//城市
	private String 	receiverDistrict;	//区/县
	private String 	receiverAddress	;//详细地址
	private String 	dSRName;	//商户名称
	private String 	dSRCode;	//商户编码
	private String 	storeCellphone	;//商户电话
	private String 	orderDate;//下单时间
	private String 	payBillTime;	//付款时间
	private String 	orderPickedTime;	//接单时间
	private String 	startDeliveryTime;	//配送时间
	private String 	receivedTime;	//收货时间
	private String evaLabelName;
	private String evaluateId;
	public String getOrderRate() {
		return orderRate;
	}
	public void setOrderRate(String orderRate) {
		this.orderRate = orderRate;
	}
	public String getContext() {
		return context;
	}
	public void setContext(String context) {
		this.context = context;
	}
	public String getIsPositive() {
		return isPositive;
	}
	public void setIsPositive(String isPositive) {
		this.isPositive = isPositive;
	}
	public String getOrderCreated() {
		return orderCreated;
	}
	public void setOrderCreated(String orderCreated) {
		this.orderCreated = orderCreated;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getOrderNumber() {
		return orderNumber;
	}
	public void setOrderNumber(String orderNumber) {
		this.orderNumber = orderNumber;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getProductCode() {
		return productCode;
	}
	public void setProductCode(String productCode) {
		this.productCode = productCode;
	}
	public String getMerchRate() {
		return merchRate;
	}
	public void setMerchRate(String merchRate) {
		this.merchRate = merchRate;
	}
	public String getCustomerPhoneNumber() {
		return customerPhoneNumber;
	}
	public void setCustomerPhoneNumber(String customerPhoneNumber) {
		this.customerPhoneNumber = customerPhoneNumber;
	}
	public String getReceiverName() {
		return receiverName;
	}
	public void setReceiverName(String receiverName) {
		this.receiverName = receiverName;
	}
	public String getReceiverPhone() {
		return receiverPhone;
	}
	public void setReceiverPhone(String receiverPhone) {
		this.receiverPhone = receiverPhone;
	}
	public String getReceiverProvince() {
		return receiverProvince;
	}
	public void setReceiverProvince(String receiverProvince) {
		this.receiverProvince = receiverProvince;
	}
	public String getReceiverCity() {
		return receiverCity;
	}
	public void setReceiverCity(String receiverCity) {
		this.receiverCity = receiverCity;
	}
	public String getReceiverDistrict() {
		return receiverDistrict;
	}
	public void setReceiverDistrict(String receiverDistrict) {
		this.receiverDistrict = receiverDistrict;
	}
	public String getReceiverAddress() {
		return receiverAddress;
	}
	public void setReceiverAddress(String receiverAddress) {
		this.receiverAddress = receiverAddress;
	}
	public String getdSRName() {
		return dSRName;
	}
	public void setdSRName(String dSRName) {
		this.dSRName = dSRName;
	}
	public String getdSRCode() {
		return dSRCode;
	}
	public void setdSRCode(String dSRCode) {
		this.dSRCode = dSRCode;
	}
	public String getStoreCellphone() {
		return storeCellphone;
	}
	public void setStoreCellphone(String storeCellphone) {
		this.storeCellphone = storeCellphone;
	}
	public String getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(String orderDate) {
		this.orderDate = orderDate;
	}
	public String getPayBillTime() {
		return payBillTime;
	}
	public void setPayBillTime(String payBillTime) {
		this.payBillTime = payBillTime;
	}
	public String getOrderPickedTime() {
		return orderPickedTime;
	}
	public void setOrderPickedTime(String orderPickedTime) {
		this.orderPickedTime = orderPickedTime;
	}
	public String getStartDeliveryTime() {
		return startDeliveryTime;
	}
	public void setStartDeliveryTime(String startDeliveryTime) {
		this.startDeliveryTime = startDeliveryTime;
	}
	public String getReceivedTime() {
		return receivedTime;
	}
	public void setReceivedTime(String receivedTime) {
		this.receivedTime = receivedTime;
	}
	public String getCustomerName() {
		return customerName;
	}
	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}
	public String getCustomerCode() {
		return customerCode;
	}
	public void setCustomerCode(String customerCode) {
		this.customerCode = customerCode;
	}
	public String getEvaLabelName() {
		return evaLabelName;
	}
	public void setEvaLabelName(String evaLabelName) {
		this.evaLabelName = evaLabelName;
	}
	public String getEvaluateId() {
		return evaluateId;
	}
	public void setEvaluateId(String evaluateId) {
		this.evaluateId = evaluateId;
	}





	
}
