package com.hand.base.order.model;

import com.hand.base.basic.model.BasicModel;

public class OrderMerchant extends BasicModel {

	private String orderNum;// 订单编号
	private String o2oDisplayName;// 商品名称
	private String o2oIntCode;// 商品编码
	private String baseUnitPri;// 报价
	private String qtyReq;// 数量
	private String attrib17;// 报价总金额
	private String netPri;// 成交价
	private String attrib19;// 成交金额
	private String attrib11;// 是否赠品
	private String contact;// 收货人
	private String contactPhone;// 收货人电话
	private String attrib36;// 省/直辖市
	private String attrib37;// 城市
	private String attrib38;// 区/县
	private String attrib01;// 详细地址
	private String attrib14;// 商品总价
	private String attrib16;// 特价优惠金额
	private String attrib21;// 满减优惠金额
	private String attrib22;// 买赠优惠金额
	private String attrib20;// 优惠券金额
	private String o2oTip;// 小费
	private String orderSum;// 订单总金额
	private String orderTime;// 下单时间
	private String attrib28;// 配送时间
	private String attrib48;// 订单状态
	private String attrib07;// 物流状态
	private String merchantOfferSum;// 商品优惠金额
	private String orderOfferSum; // 订单优惠金额分摊

	public String getOrderNum() {
		return orderNum;
	}

	public void setOrderNum(String orderNum) {
		this.orderNum = orderNum;
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

	public String getBaseUnitPri() {
		return baseUnitPri;
	}

	public void setBaseUnitPri(String baseUnitPri) {
		this.baseUnitPri = baseUnitPri;
	}

	public String getQtyReq() {
		if (qtyReq != null && qtyReq.indexOf(".") > 0) {
			return qtyReq.substring(0, qtyReq.indexOf("."));
		}
		return qtyReq;
	}

	public void setQtyReq(String qtyReq) {
		this.qtyReq = qtyReq;
	}

	public String getAttrib17() {
		return attrib17;
	}

	public void setAttrib17(String attrib17) {
		this.attrib17 = attrib17;
	}

	public String getNetPri() {
		return netPri;
	}

	public void setNetPri(String netPri) {
		this.netPri = netPri;
	}

	public String getAttrib19() {
		return attrib19;
	}

	public void setAttrib19(String attrib19) {
		this.attrib19 = attrib19;
	}

	public String getAttrib11() {
		return attrib11;
	}

	public void setAttrib11(String attrib11) {
		this.attrib11 = attrib11;
	}

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

	public String getAttrib36() {
		return attrib36;
	}

	public void setAttrib36(String attrib36) {
		this.attrib36 = attrib36;
	}

	public String getAttrib37() {
		return attrib37;
	}

	public void setAttrib37(String attrib37) {
		this.attrib37 = attrib37;
	}

	public String getAttrib38() {
		return attrib38;
	}

	public void setAttrib38(String attrib38) {
		this.attrib38 = attrib38;
	}

	public String getAttrib01() {
		return attrib01;
	}

	public void setAttrib01(String attrib01) {
		this.attrib01 = attrib01;
	}

	public String getAttrib14() {
		return attrib14;
	}

	public void setAttrib14(String attrib14) {
		this.attrib14 = attrib14;
	}

	public String getAttrib16() {
		return attrib16;
	}

	public void setAttrib16(String attrib16) {
		this.attrib16 = attrib16;
	}

	public String getAttrib21() {
		return attrib21;
	}

	public void setAttrib21(String attrib21) {
		this.attrib21 = attrib21;
	}

	public String getAttrib22() {
		return attrib22;
	}

	public void setAttrib22(String attrib22) {
		this.attrib22 = attrib22;
	}

	public String getAttrib20() {
		return attrib20;
	}

	public void setAttrib20(String attrib20) {
		this.attrib20 = attrib20;
	}

	public String getO2oTip() {
		return o2oTip;
	}

	public void setO2oTip(String o2oTip) {
		this.o2oTip = o2oTip;
	}

	public String getOrderSum() {
		return orderSum;
	}

	public void setOrderSum(String orderSum) {
		this.orderSum = orderSum;
	}

	public String getOrderTime() {
		return orderTime;
	}

	public void setOrderTime(String orderTime) {
		this.orderTime = orderTime;
	}

	public String getAttrib28() {
		return attrib28;
	}

	public void setAttrib28(String attrib28) {
		this.attrib28 = attrib28;
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

	public String getMerchantOfferSum() {
		return merchantOfferSum;
	}

	public void setMerchantOfferSum(String merchantOfferSum) {
		this.merchantOfferSum = merchantOfferSum;
	}

	public String getOrderOfferSum() {
		return orderOfferSum;
	}

	public void setOrderOfferSum(String orderOfferSum) {
		this.orderOfferSum = orderOfferSum;
	}

}
