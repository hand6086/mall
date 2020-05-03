package com.hand.base.charge.model;

import com.hand.base.basic.model.BasicModel;

public class Settlement extends BasicModel {
	private String cityName;// 城市名// created 下单时间
	private String notes;// 说明
	private String name;// 商户名称
	private String code;//
	private String cityId;//
	private String startDate;// 开始日期
	private String endDate;// 结束日期
	private String isGenerated;// 是否生成批次
	private String tAttr10;// 状态
	private String ouNum;// 商户编码
	private String o2oContactPhone;// 商户电话
	private String o2oAlipay;// 支付宝账户
	private String o2oBank;// 开户银行
	private String o2oAccontName;// 开户人
	private String o2oCreditCard;// 银行卡号
	private String tAttr04;// 结算总金额
	private String settleTime;// 结算时间
	private String status;// 状态(第二个行) 支付状态
	private String headId;// (第二个行关联字段)
	private String paymentNumber;// 支付流水号
	private String paymentAcct;// 支付账号
	private String receiveAcct;// 收款账号
	private String amount;// 交易金额
	private String tAttr01;// 交易类型
	private String type;// 支付方式
	private String orderNum;// 订单编号
	private String attrib27;// 接单时间
	private String attrib26;// 付款时间
	private String attrib29;// 收货时间
	private String attrib28;// 配送时间
	private String attrib33;// 结算时间
	private String attrib46;// 结算状态
	private String colSetLineId;// 第三行关联字段

	public Settlement() {
		super();
	}

	public String getCityName() {
		return cityName;
	}

	public void setCityName(String cityName) {
		this.cityName = cityName;
	}

	public String getNotes() {
		return notes;
	}

	public void setNotes(String notes) {
		this.notes = notes;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getCityId() {
		return cityId;
	}

	public void setCityId(String cityId) {
		this.cityId = cityId;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getIsGenerated() {
		return isGenerated;
	}

	public void setIsGenerated(String isGenerated) {
		this.isGenerated = isGenerated;
	}

	public String gettAttr10() {
		return tAttr10;
	}

	public void settAttr10(String tAttr10) {
		this.tAttr10 = tAttr10;
	}

	public String getOuNum() {
		return ouNum;
	}

	public void setOuNum(String ouNum) {
		this.ouNum = ouNum;
	}

	public String getO2oContactPhone() {
		return o2oContactPhone;
	}

	public void setO2oContactPhone(String o2oContactPhone) {
		this.o2oContactPhone = o2oContactPhone;
	}

	public String getO2oAlipay() {
		return o2oAlipay;
	}

	public void setO2oAlipay(String o2oAlipay) {
		this.o2oAlipay = o2oAlipay;
	}

	public String getO2oBank() {
		return o2oBank;
	}

	public void setO2oBank(String o2oBank) {
		this.o2oBank = o2oBank;
	}

	public String getO2oAccontName() {
		return o2oAccontName;
	}

	public void setO2oAccontName(String o2oAccontName) {
		this.o2oAccontName = o2oAccontName;
	}

	public String getO2oCreditCard() {
		return o2oCreditCard;
	}

	public void setO2oCreditCard(String o2oCreditCard) {
		this.o2oCreditCard = o2oCreditCard;
	}

	public String gettAttr04() {
		if (tAttr04 != null && tAttr04.indexOf(".") > 0) {
			return tAttr04.substring(0, tAttr04.indexOf("."));
		}
		return tAttr04;
	}

	public void settAttr04(String tAttr04) {
		this.tAttr04 = tAttr04;
	}

	public String getSettleTime() {
		return settleTime;
	}

	public void setSettleTime(String settleTime) {
		this.settleTime = settleTime;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getHeadId() {
		return headId;
	}

	public void setHeadId(String headId) {
		this.headId = headId;
	}

	public String getPaymentNumber() {
		return paymentNumber;
	}

	public void setPaymentNumber(String paymentNumber) {
		this.paymentNumber = paymentNumber;
	}

	public String getPaymentAcct() {
		return paymentAcct;
	}

	public void setPaymentAcct(String paymentAcct) {
		this.paymentAcct = paymentAcct;
	}

	public String getColSetLineId() {
		return colSetLineId;
	}

	public void setColSetLineId(String colSetLineId) {
		this.colSetLineId = colSetLineId;
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

	public String gettAttr01() {
		return tAttr01;
	}

	public void settAttr01(String tAttr01) {
		this.tAttr01 = tAttr01;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getOrderNum() {
		return orderNum;
	}

	public void setOrderNum(String orderNum) {
		this.orderNum = orderNum;
	}

	public String getAttrib27() {
		return attrib27;
	}

	public void setAttrib27(String attrib27) {
		this.attrib27 = attrib27;
	}

	public String getAttrib26() {
		return attrib26;
	}

	public void setAttrib26(String attrib26) {
		this.attrib26 = attrib26;
	}

	public String getAttrib29() {
		return attrib29;
	}

	public void setAttrib29(String attrib29) {
		this.attrib29 = attrib29;
	}

	public String getAttrib28() {
		return attrib28;
	}

	public void setAttrib28(String attrib28) {
		this.attrib28 = attrib28;
	}

	public String getAttrib33() {
		return attrib33;
	}

	public void setAttrib33(String attrib33) {
		this.attrib33 = attrib33;
	}

	public String getAttrib46() {
		return attrib46;
	}

	public void setAttrib46(String attrib46) {
		this.attrib46 = attrib46;
	}

}
