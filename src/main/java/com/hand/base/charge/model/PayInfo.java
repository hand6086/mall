package com.hand.base.charge.model;

import com.hand.base.basic.model.BasicModel;

public class PayInfo extends BasicModel {
	private String paymentNumber; // 支付流水号
	private String attr01;// 交易类型
	private String orderNum;// 订单编号
	private String paymentAcct;// 支付账号
	private String receiveAcct;// 收款账号
	private String amount;// 交易金额
	private String name;// 商户名称
	private String city;// 城市
	private String orderTime;// 下单时间
	private String attrib29;// 收货时间
	private String attrib48;// 订单状态
	private String attrib07;// 物流状态
	private String ouNum;// 商户编码
	private String o2oContact;// 联系人
	private String o2oContactPhone;// 联系人电话
	private String o2oCreditCard; // 银行卡号
	private String o2oAlipay;// 支付宝账号
	private String accontName;// 开户人
	private String o2oBank;// 发卡银行
	private String status;// 状态
	private String type;// 支付方式
	private String tradeTime;// 交易时间
	private String orderDt;// 订单日期

	public PayInfo() {
		super();
	}

	public String getPaymentNumber() {
		return paymentNumber;
	}

	public void setPaymentNumber(String paymentNumber) {
		this.paymentNumber = paymentNumber;
	}

	public String getAttr01() {
		return attr01;
	}

	public void setAttr01(String attr01) {
		this.attr01 = attr01;
	}

	public String getOrderNum() {
		return orderNum;
	}

	public void setOrderNum(String orderNum) {
		this.orderNum = orderNum;
	}

	public String getPaymentAcct() {
		return paymentAcct;
	}

	public void setPaymentAcct(String paymentAcct) {
		this.paymentAcct = paymentAcct;
	}

	public String getReceiveAcct() {
		return receiveAcct;
	}

	public void setReceiveAcct(String receiveAcct) {
		this.receiveAcct = receiveAcct;
	}

	public String getAmount() {
		if (amount != null) {
			int index = amount.indexOf(".");
			if (index > 0 && amount.length() >= index + 3) {
				return amount.substring(0, index + 3);
			}
		}
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getOrderTime() {
		return orderTime;
	}

	public void setOrderTime(String orderTime) {
		this.orderTime = orderTime;
	}

	public String getAttrib29() {
		return attrib29;
	}

	public void setAttrib29(String attrib29) {
		this.attrib29 = attrib29;
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

	public String getOuNum() {
		return ouNum;
	}

	public void setOuNum(String ouNum) {
		this.ouNum = ouNum;
	}

	public String getO2oContact() {
		return o2oContact;
	}

	public void setO2oContact(String o2oContact) {
		this.o2oContact = o2oContact;
	}

	public String getO2oContactPhone() {
		return o2oContactPhone;
	}

	public void setO2oContactPhone(String o2oContactPhone) {
		this.o2oContactPhone = o2oContactPhone;
	}

	public String getO2oCreditCard() {
		return o2oCreditCard;
	}

	public void setO2oCreditCard(String o2oCreditCard) {
		this.o2oCreditCard = o2oCreditCard;
	}

	public String getO2oAlipay() {
		return o2oAlipay;
	}

	public void setO2oAlipay(String o2oAlipay) {
		this.o2oAlipay = o2oAlipay;
	}

	public String getAccontName() {
		return accontName;
	}

	public void setAccontName(String accontName) {
		this.accontName = accontName;
	}

	public String getO2oBank() {
		return o2oBank;
	}

	public void setO2oBank(String o2oBank) {
		this.o2oBank = o2oBank;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getTradeTime() {
		return tradeTime;
	}

	public void setTradeTime(String tradeTime) {
		this.tradeTime = tradeTime;
	}

	public String getOrderDt() {
		return orderDt;
	}

	public void setOrderDt(String orderDt) {
		this.orderDt = orderDt;
	}

}
