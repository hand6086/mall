package com.hand.base.order.model;

import com.hand.base.basic.model.BasicModel;

public class CancelPermission extends BasicModel {
	private String attrib48;// 订单状态//created 下单时间
	private String orderNum;// 订单编号
	private String attrib54;// 外部订单编号
	private String customerName;// 消费者名称
	private String customerOuNum;// 消费者编码
	private String mainPhNum;// 消费者电话
	private String attrib39;// 店铺名称
	private String contact;// 收货人
	private String contactPhone;// 收货人电话
	private String attrib36;// 省/直辖市
	private String attrib37;// 城市
	private String attrib38;// 区/县
	private String attrib01;// 详细地址
	private String gpsLongitude;// GPS经度
	private String gpsLatitude;// GPS纬度
	private String attrib14;// 商品总价
	private String attrib16;// 特价优惠金额
	private String attrib22;// 买赠优惠金额
	private String attrib21;// 满减优惠金额
	private String attrib20;// 优惠券金额
	private String offerSum;// 优惠总金额
	private String o2oTip;// 小费
	private String attrib17;// 订单总金额 //报价总金额
	private String o2oPayType;// 支付方式
	private String attrib47;// 买家留言
	private String attrib40;// 配送方式
	private String attrib07;// 物流状态
	private String merchantName;// 商户名称
	private String merchantOuNum;// 商户编码
	private String o2oContactPhone;// 商户电话
	private String o2oStoreType;// 商户类型
	private String distributor;// 配送员
	private String attrib42;// 配送员电话
	private String attrib44;// O2O订单分类
	private String o2oForcedPickup;// 是否兜底订单
	private String attrib50;// 是否团购订单
	private String attrib55;// 是否秒杀订单
	private String attrib43;// 校验码
	private String attrib49;// 校验状态
	private String attrib26;// 付款时间
	private String attrib27;// 接单时间
	private String attrib28;// 配送时间
	private String attrib29;// 收货时间
	private String attrib46;// 结算状态
	private String attrib53;// 来源系统
	private String typeName;// 类型
	private String attrib09;// 是否O2O订单
	private String attrib30;// 第一轮推送时间
	private String attrib31;// 第二轮推送时间
	private String attrib32;// 第三轮推送时间
	private String attrib57; // 取消时间

	private String o2oDisplayName;// 商品名称
	private String o2oIntCode;// 商品编码
	private String baseUnitPri;// 报价
	private String qtyReq;// 数量
	private String netPri;// 成交价
	private String attrib19;// 成交金额
	private String o2oGpProd;// 是否团购商品
	private String attrib11;// 是否赠品
	private String merchantOfferSum;// 商品优惠金额
	private String orderOfferSum; // 订单优惠金额分摊

	public String getAttrib48() {
		return attrib48;
	}

	public void setAttrib48(String attrib48) {
		this.attrib48 = attrib48;
	}

	public String getOrderNum() {
		return orderNum;
	}

	public void setOrderNum(String orderNum) {
		this.orderNum = orderNum;
	}

	public String getAttrib54() {
		return attrib54;
	}

	public void setAttrib54(String attrib54) {
		this.attrib54 = attrib54;
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

	public String getAttrib39() {
		return attrib39;
	}

	public void setAttrib39(String attrib39) {
		this.attrib39 = attrib39;
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

	public String getGpsLongitude() {
		if (gpsLongitude != null) {
			int index = gpsLongitude.indexOf(".");
			if (index > 0 && gpsLongitude.length() >= index + 3) {
				return gpsLongitude.substring(0, index + 3);
			}
		}
		return gpsLongitude;
	}

	public void setGpsLongitude(String gpsLongitude) {
		this.gpsLongitude = gpsLongitude;
	}

	public String getGpsLatitude() {
		if (gpsLatitude != null) {
			int index = gpsLatitude.indexOf(".");
			if (index > 0 && gpsLatitude.length() >= index + 3) {
				return gpsLatitude.substring(0, index + 3);
			}
		}
		return gpsLatitude;
	}

	public void setGpsLatitude(String gpsLatitude) {
		this.gpsLatitude = gpsLatitude;
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

	public String getAttrib20() {
		return attrib20;
	}

	public void setAttrib20(String attrib20) {
		this.attrib20 = attrib20;
	}

	public String getOfferSum() {
		return offerSum;
	}

	public void setOfferSum(String offerSum) {
		this.offerSum = offerSum;
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

	public String getO2oPayType() {
		return o2oPayType;
	}

	public void setO2oPayType(String o2oPayType) {
		this.o2oPayType = o2oPayType;
	}

	public String getAttrib47() {
		return attrib47;
	}

	public void setAttrib47(String attrib47) {
		this.attrib47 = attrib47;
	}

	public String getAttrib40() {
		return attrib40;
	}

	public void setAttrib40(String attrib40) {
		this.attrib40 = attrib40;
	}

	public String getAttrib07() {
		return attrib07;
	}

	public void setAttrib07(String attrib07) {
		this.attrib07 = attrib07;
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

	public String getO2oContactPhone() {
		return o2oContactPhone;
	}

	public void setO2oContactPhone(String o2oContactPhone) {
		this.o2oContactPhone = o2oContactPhone;
	}

	public String getO2oStoreType() {
		return o2oStoreType;
	}

	public void setO2oStoreType(String o2oStoreType) {
		this.o2oStoreType = o2oStoreType;
	}

	public String getDistributor() {
		return distributor;
	}

	public void setDistributor(String distributor) {
		this.distributor = distributor;
	}

	public String getAttrib42() {
		return attrib42;
	}

	public void setAttrib42(String attrib42) {
		this.attrib42 = attrib42;
	}

	public String getAttrib44() {
		return attrib44;
	}

	public void setAttrib44(String attrib44) {
		this.attrib44 = attrib44;
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

	public String getAttrib43() {
		return attrib43;
	}

	public void setAttrib43(String attrib43) {
		this.attrib43 = attrib43;
	}

	public String getAttrib49() {
		return attrib49;
	}

	public void setAttrib49(String attrib49) {
		this.attrib49 = attrib49;
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

	public String getAttrib46() {
		return attrib46;
	}

	public void setAttrib46(String attrib46) {
		this.attrib46 = attrib46;
	}

	public String getAttrib53() {
		return attrib53;
	}

	public void setAttrib53(String attrib53) {
		this.attrib53 = attrib53;
	}

	public String getTypeName() {
		return typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}

	public String getAttrib09() {
		return attrib09;
	}

	public void setAttrib09(String attrib09) {
		this.attrib09 = attrib09;
	}

	public String getAttrib30() {
		return attrib30;
	}

	public void setAttrib30(String attrib30) {
		this.attrib30 = attrib30;
	}

	public String getAttrib31() {
		return attrib31;
	}

	public void setAttrib31(String attrib31) {
		this.attrib31 = attrib31;
	}

	public String getAttrib32() {
		return attrib32;
	}

	public void setAttrib32(String attrib32) {
		this.attrib32 = attrib32;
	}

	public String getAttrib57() {
		return attrib57;
	}

	public void setAttrib57(String attrib57) {
		this.attrib57 = attrib57;
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

	public String getO2oGpProd() {
		return o2oGpProd;
	}

	public void setO2oGpProd(String o2oGpProd) {
		this.o2oGpProd = o2oGpProd;
	}

	public String getAttrib11() {
		return attrib11;
	}

	public void setAttrib11(String attrib11) {
		this.attrib11 = attrib11;
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
