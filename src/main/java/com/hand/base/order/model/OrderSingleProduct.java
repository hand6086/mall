package com.hand.base.order.model;

import com.hand.base.basic.model.BasicModel;

public class OrderSingleProduct extends BasicModel {

	private String o2oProductDisplayName;// 单品名称 //下单时间
	private String o2oProductIntCode;// 单品编码
	private String name;// 单品产品名称
	private String partNum;// 单品产品编码
	private String baseUnitPri;// 报价
	private String netPrice;// 成交价
	private String dealNumber;// 成交数量
	private String quotedPriceSum;// 报价总金额
	private String dealSum;// 成交总金额
	private String o2oMerchantDisplayName;// 套装商品名称
	private String o2oMerchantIntCode;// 套装商品编码
	private String orderOfferSum;// 订单优惠金额分摊
	private String merchantOfferSum;// 商品优惠金额分摊
	private String attrib11;// 是否赠品
	private String o2oGpProd;// 是否团购商品
	private String orderNum;// 订单编号
	private String contact;// 收货人
	private String contactPhone;// 收货电话
	private String attrib36;// 省/直辖市
	private String attrib37;// 城市
	private String attrib38;// 区/县
	private String attrib01;// 详细地址
	private String attrib26;// 付款时间
	private String attrib27;// 接单时间
	private String attrib28;// 配送时间
	private String attrib29;// 收货时间
	private String attrib14;// 商品总价
	private String attrib16;// 特价优惠金额
	private String attrib20;// 优惠券金额
	private String attrib22;// 买赠优惠金额
	private String attrib21;// 满减优惠金额
	private String o2oTip;// 小费
	private String attrib17;// 订单总金额
	private String merchantName;// 商户名称
	private String merchantOuNum;// 商户编码
	private String customerName;// 消费者名称
	private String customerOuNum;// 消费者编码
	private String mainPhNum;// 消费者电话
	private String o2oForcedPickup;// 是否兜底订单
	private String attrib50;// 是否团购订单
	private String attrib55;// 是否秒杀订单
	private String attrib48;// 订单状态
	private String attrib07; // 物流状态

	public String getO2oProductDisplayName() {
		return o2oProductDisplayName;
	}

	public void setO2oProductDisplayName(String o2oProductDisplayName) {
		this.o2oProductDisplayName = o2oProductDisplayName;
	}

	public String getO2oProductIntCode() {
		return o2oProductIntCode;
	}

	public void setO2oProductIntCode(String o2oProductIntCode) {
		this.o2oProductIntCode = o2oProductIntCode;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPartNum() {
		return partNum;
	}

	public void setPartNum(String partNum) {
		this.partNum = partNum;
	}

	public String getBaseUnitPri() {
		return baseUnitPri;
	}

	public void setBaseUnitPri(String baseUnitPri) {
		this.baseUnitPri = baseUnitPri;
	}

	public String getNetPrice() {
		return netPrice;
	}

	public void setNetPrice(String netPrice) {
		this.netPrice = netPrice;
	}

	public String getDealNumber() {
		if (dealNumber != null && dealNumber.indexOf(".") > 0) {
			return dealNumber.substring(0, dealNumber.indexOf("."));
		}
		return dealNumber;
	}

	public void setDealNumber(String dealNumber) {
		this.dealNumber = dealNumber;
	}

	public String getQuotedPriceSum() {
		return quotedPriceSum;
	}

	public void setQuotedPriceSum(String quotedPriceSum) {
		this.quotedPriceSum = quotedPriceSum;
	}

	public String getDealSum() {
		return dealSum;
	}

	public void setDealSum(String dealSum) {
		this.dealSum = dealSum;
	}

	public String getO2oMerchantDisplayName() {
		return o2oMerchantDisplayName;
	}

	public void setO2oMerchantDisplayName(String o2oMerchantDisplayName) {
		this.o2oMerchantDisplayName = o2oMerchantDisplayName;
	}

	public String getO2oMerchantIntCode() {
		return o2oMerchantIntCode;
	}

	public void setO2oMerchantIntCode(String o2oMerchantIntCode) {
		this.o2oMerchantIntCode = o2oMerchantIntCode;
	}

	public String getOrderOfferSum() {
		return orderOfferSum;
	}

	public void setOrderOfferSum(String orderOfferSum) {
		this.orderOfferSum = orderOfferSum;
	}

	public String getMerchantOfferSum() {
		return merchantOfferSum;
	}

	public void setMerchantOfferSum(String merchantOfferSum) {
		this.merchantOfferSum = merchantOfferSum;
	}

	public String getAttrib11() {
		return attrib11;
	}

	public void setAttrib11(String attrib11) {
		this.attrib11 = attrib11;
	}

	public String getO2oGpProd() {
		return o2oGpProd;
	}

	public void setO2oGpProd(String o2oGpProd) {
		this.o2oGpProd = o2oGpProd;
	}

	public String getOrderNum() {
		return orderNum;
	}

	public void setOrderNum(String orderNum) {
		this.orderNum = orderNum;
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

	public String getAttrib26() {
		return attrib26;
	}

	public void setAttrib26(String attrib26) {
		this.attrib26 = attrib26;
	}

	public String getAttrib27() {
		return attrib27;
	}

	public void setAttrib27(String attrib27) {
		this.attrib27 = attrib27;
	}

	public String getAttrib28() {
		return attrib28;
	}

	public void setAttrib28(String attrib28) {
		this.attrib28 = attrib28;
	}

	public String getAttrib29() {
		return attrib29;
	}

	public void setAttrib29(String attrib29) {
		this.attrib29 = attrib29;
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

	public String getAttrib20() {
		return attrib20;
	}

	public void setAttrib20(String attrib20) {
		this.attrib20 = attrib20;
	}

	public String getAttrib22() {
		return attrib22;
	}

	public void setAttrib22(String attrib22) {
		this.attrib22 = attrib22;
	}

	public String getAttrib21() {
		return attrib21;
	}

	public void setAttrib21(String attrib21) {
		this.attrib21 = attrib21;
	}

	public String getO2oTip() {
		return o2oTip;
	}

	public void setO2oTip(String o2oTip) {
		this.o2oTip = o2oTip;
	}

	public String getAttrib17() {
		return attrib17;
	}

	public void setAttrib17(String attrib17) {
		this.attrib17 = attrib17;
	}

	public String getMerchantName() {
		return merchantName;
	}

	public void setMerchantName(String merchantName) {
		this.merchantName = merchantName;
	}

	public String getMerchantOuNum() {
		return merchantOuNum;
	}

	public void setMerchantOuNum(String merchantOuNum) {
		this.merchantOuNum = merchantOuNum;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public String getCustomerOuNum() {
		return customerOuNum;
	}

	public void setCustomerOuNum(String customerOuNum) {
		this.customerOuNum = customerOuNum;
	}

	public String getMainPhNum() {
		return mainPhNum;
	}

	public void setMainPhNum(String mainPhNum) {
		this.mainPhNum = mainPhNum;
	}

	public String getO2oForcedPickup() {
		return o2oForcedPickup;
	}

	public void setO2oForcedPickup(String o2oForcedPickup) {
		this.o2oForcedPickup = o2oForcedPickup;
	}

	public String getAttrib50() {
		return attrib50;
	}

	public void setAttrib50(String attrib50) {
		this.attrib50 = attrib50;
	}

	public String getAttrib55() {
		return attrib55;
	}

	public void setAttrib55(String attrib55) {
		this.attrib55 = attrib55;
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

}
