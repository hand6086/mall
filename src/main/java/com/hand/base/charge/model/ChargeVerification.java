package com.hand.base.charge.model;

import com.hand.base.basic.model.BasicModel;

public class ChargeVerification extends BasicModel {
	private String notes;/* 说明 */
	private String cityId;/* 与子级关联字段 */
	private String cityName;/* 城市名 */

	private String startDate;/* 开始日期 */
	private String endDate;/* 结束日期 */
	private String isGenerated;/* 是否生成批次 */

	private String tAttr04;/* 核销总金额 */
	private String status;/* 核销状态 */
	private String ouNum;/* 商户编码 */
	private String name;/* 商户名称 */
	private String o2oContactPhone;/* 商户电话 */
	private String o2oAlipay;/* 支付宝账户 */
	private String o2oBank;/* 开户银行 */
	private String o2oAccontName;/* 开户人 */
	private String o2oCreditCard;/* 银行卡号 */
	private String headId;/* 与父级相关 */

	private String orderNum;/* 订单编号 */
	/* private String created;下单时间 */
	private String attrib27;/* 接单时间 */
	private String attrib26;/* 付款时间 */
	private String attrib29;/* 收货时间 */
	private String attrib28;/* 配送时间 */
	private String xAttrib66;/* 费用核销确认时间 */
	private String sumCharge;/* 需核销费用总额 */
	private String expVrfLnId;/* 与父级相关 */

	public String getNotes() {
		return notes;
	}

	public void setNotes(String notes) {
		this.notes = notes;
	}

	public String getCityId() {
		return cityId;
	}

	public void setCityId(String cityId) {
		this.cityId = cityId;
	}

	public String getCityName() {
		return cityName;
	}

	public void setCityName(String cityName) {
		this.cityName = cityName;
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

	public String gettAttr04() {
		if (tAttr04 != null && tAttr04.indexOf(".") > 0) {
			return tAttr04.substring(0, tAttr04.indexOf("."));
		}
		return tAttr04;
	}

	public void settAttr04(String tAttr04) {
		this.tAttr04 = tAttr04;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getOuNum() {
		return ouNum;
	}

	public void setOuNum(String ouNum) {
		this.ouNum = ouNum;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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

	public String getxAttrib66() {
		return xAttrib66;
	}

	public void setxAttrib66(String xAttrib66) {
		this.xAttrib66 = xAttrib66;
	}

	public String getSumCharge() {
		if (sumCharge != null && sumCharge.indexOf(".") > 0) {
			return sumCharge.substring(0, sumCharge.indexOf("."));
		}
		return sumCharge;
	}

	public void setSumCharge(String sumCharge) {
		this.sumCharge = sumCharge;
	}

	public String getHeadId() {
		return headId;
	}

	public void setHeadId(String headId) {
		this.headId = headId;
	}

	public String getExpVrfLnId() {
		return expVrfLnId;
	}

	public void setExpVrfLnId(String expVrfLnId) {
		this.expVrfLnId = expVrfLnId;
	}

}
