package com.hand.base.aftersalemanagement.model;

import com.hand.base.basic.model.BasicModel;
import com.hand.core.util.AppConstants;

public class WithRefundOrder extends BasicModel {
	private String 	orderNumber;	//订单编号
	private String o2oExloderNumber;	//外部订单编号改
	private String	o2oPayInfoType;	//在线支付方式
	private String	account	;//消费者名称
	private String	accountCode;	//消费者编码
	private String	mainPhoneNumber	;//消费者电话
	private String	o2oStoreName	;//店铺名称
	private String	o2oReceiverName	;//收货人
	private String	o2oReceiverPhone;	//收货人电话
	private String	o2oReceiverProvince;	//省/直辖市
	private String	o2oReceiverCity	;//城市
	private String	o2oReceiverDistrict;	//区/县
	private String	o2oReceiverAddress;	//详细地址
	private String	o2oGPSLongitude	;//GPS经度
	private String	o2oGPSLatitude;	//GPS纬度
	private String	o2omerchandiseprice;	//商品总价
	private String	o2oDeducedPrice	;//特价优惠金额
	private String	o2oFreeGetPrice;	//买赠优惠金额
	private String	o2oFullCutAmount;	//满减优惠金额
	private String	o2oCouponValue	;//优惠券金额
	private String	o2oTip	;//小费
	private String	o2oorderTotalPrice;	//订单总金额
	private String	o2oPayType;	//支付方式
	private String	o2oCustomerMsg;	//买家留言
	private String	o2oDeliveryType	;//配送方式
	private String	o2oLogisticsStatus;	//物流状态
	private String	o2oDSRName	;//商户名称
	private String	o2oDSRCode;	//商户编码
	private String	o2oStoreCellphone;//	商户电话
	private String	o2oDSRStoreType;	//商户类型
	private String	o2oDeliveryMan;	//配送员
	private String	o2oDeliveryManphone;	//配送员电话改
	private String	o2oorderType;	//o2o订单分类
	private String	o2oIsForcedPickup;	//是否兜底订单
	private String	o2oIsGroPurorder	;//是否团购订单gai
	private String	o2oCheckCode;	//校验码
	private String	o2oCheckStatus	;//校验状态
	
	private String	orderCreated	;//下单时间
	private String	o2oPayBillTime;	//付款时间gai
	private String	o2oorderPickedT	;//接单时间gai
	private String	o2oStartDeliveryT;	//配送时间
	private String	o2oReceivedTime	;//收货时间
	private String	o2oorderStatus;	//订单状态
	private String	o2oorderSourceSystem;	//来源系统
	private String	orderType	;//类型
	private String	o2oiso2oorder	;//是否o2o订单
	private String	o2o1stPushTime	;//第一轮推送时间
	private String	o2o2ndPushTime	;//第二轮推送时间
	private String	o2o3rdPushTime	;//第三轮推送时间
	
	private String merchandiseName;//商品名称
	private String merchandiseCode;//商品编码
	private String basePrice;//报价
	
	private String quantityRequested;//数量
	private String o2oOriMePrice;//报价总金额
	private String netPrice;//成交价
	private String o2oLineTotalPrice;//成交金额
	private String o2ooGPProd;//是否团购商品
	private String o2oIsFreeMerchandise;//是否赠品
	private String orderHeaderId;
	
	
	private String userRefundUrl;
	public String getMerchandiseName() {
		return merchandiseName;
	}
	public void setMerchandiseName(String merchandiseName) {
		this.merchandiseName = merchandiseName;
	}
	public String getMerchandiseCode() {
		return merchandiseCode;
	}
	public void setMerchandiseCode(String merchandiseCode) {
		this.merchandiseCode = merchandiseCode;
	}
	public String getBasePrice() {
		return basePrice;
	}
	public void setBasePrice(String basePrice) {
		this.basePrice = basePrice;
	}
	public String getQuantityRequested() {
		return quantityRequested;
	}
	public void setQuantityRequested(String quantityRequested) {
		this.quantityRequested = quantityRequested;
	}
	public String getO2oOriMePrice() {
		return o2oOriMePrice;
	}
	public void setO2oOriMePrice(String o2oOriMePrice) {
		this.o2oOriMePrice = o2oOriMePrice;
	}
	public String getNetPrice() {
		return netPrice;
	}
	public void setNetPrice(String netPrice) {
		this.netPrice = netPrice;
	}
	public String getO2oLineTotalPrice() {
		return o2oLineTotalPrice;
	}
	public void setO2oLineTotalPrice(String o2oLineTotalPrice) {
		this.o2oLineTotalPrice = o2oLineTotalPrice;
	}
	public String getO2ooGPProd() {
		return o2ooGPProd;
	}
	public void setO2ooGPProd(String o2ooGPProd) {
		this.o2ooGPProd = o2ooGPProd;
	}
	public String getO2oIsFreeMerchandise() {
		return o2oIsFreeMerchandise;
	}
	public void setO2oIsFreeMerchandise(String o2oIsFreeMerchandise) {
		this.o2oIsFreeMerchandise = o2oIsFreeMerchandise;
	}
	public String getOrderNumber() {
		return orderNumber;
	}
	public void setOrderNumber(String orderNumber) {
		this.orderNumber = orderNumber;
	}
	public String getO2oExloderNumber() {
		return o2oExloderNumber;
	}
	public void setO2oExloderNumber(String o2oExloderNumber) {
		this.o2oExloderNumber = o2oExloderNumber;
	}
	public String getO2oPayInfoType() {
		return o2oPayInfoType;
	}
	public void setO2oPayInfoType(String o2oPayInfoType) {
		this.o2oPayInfoType = o2oPayInfoType;
	}
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public String getAccountCode() {
		return accountCode;
	}
	public void setAccountCode(String accountCode) {
		this.accountCode = accountCode;
	}
	public String getMainPhoneNumber() {
		return mainPhoneNumber;
	}
	public void setMainPhoneNumber(String mainPhoneNumber) {
		this.mainPhoneNumber = mainPhoneNumber;
	}
	public String getO2oStoreName() {
		return o2oStoreName;
	}
	public void setO2oStoreName(String o2oStoreName) {
		this.o2oStoreName = o2oStoreName;
	}
	public String getO2oReceiverName() {
		return o2oReceiverName;
	}
	public void setO2oReceiverName(String o2oReceiverName) {
		this.o2oReceiverName = o2oReceiverName;
	}
	public String getO2oReceiverPhone() {
		return o2oReceiverPhone;
	}
	public void setO2oReceiverPhone(String o2oReceiverPhone) {
		this.o2oReceiverPhone = o2oReceiverPhone;
	}
	public String getO2oReceiverProvince() {
		return o2oReceiverProvince;
	}
	public void setO2oReceiverProvince(String o2oReceiverProvince) {
		this.o2oReceiverProvince = o2oReceiverProvince;
	}
	public String getO2oReceiverCity() {
		return o2oReceiverCity;
	}
	public void setO2oReceiverCity(String o2oReceiverCity) {
		this.o2oReceiverCity = o2oReceiverCity;
	}
	public String getO2oReceiverDistrict() {
		return o2oReceiverDistrict;
	}
	public void setO2oReceiverDistrict(String o2oReceiverDistrict) {
		this.o2oReceiverDistrict = o2oReceiverDistrict;
	}
	public String getO2oReceiverAddress() {
		return o2oReceiverAddress;
	}
	public void setO2oReceiverAddress(String o2oReceiverAddress) {
		this.o2oReceiverAddress = o2oReceiverAddress;
	}
	public String getO2oGPSLongitude() {
		return o2oGPSLongitude;
	}
	public void setO2oGPSLongitude(String o2oGPSLongitude) {
		this.o2oGPSLongitude = o2oGPSLongitude;
	}
	public String getO2oGPSLatitude() {
		return o2oGPSLatitude;
	}
	public void setO2oGPSLatitude(String o2oGPSLatitude) {
		this.o2oGPSLatitude = o2oGPSLatitude;
	}
	public String getO2omerchandiseprice() {
		return o2omerchandiseprice;
	}
	public void setO2omerchandiseprice(String o2omerchandiseprice) {
		this.o2omerchandiseprice = o2omerchandiseprice;
	}
	public String getO2oDeducedPrice() {
		return o2oDeducedPrice;
	}
	public void setO2oDeducedPrice(String o2oDeducedPrice) {
		this.o2oDeducedPrice = o2oDeducedPrice;
	}
	public String getO2oFreeGetPrice() {
		return o2oFreeGetPrice;
	}
	public void setO2oFreeGetPrice(String o2oFreeGetPrice) {
		this.o2oFreeGetPrice = o2oFreeGetPrice;
	}
	public String getO2oFullCutAmount() {
		return o2oFullCutAmount;
	}
	public void setO2oFullCutAmount(String o2oFullCutAmount) {
		this.o2oFullCutAmount = o2oFullCutAmount;
	}
	public String getO2oCouponValue() {
		return o2oCouponValue;
	}
	public void setO2oCouponValue(String o2oCouponValue) {
		this.o2oCouponValue = o2oCouponValue;
	}
	public String getO2oTip() {
		return o2oTip;
	}
	public void setO2oTip(String o2oTip) {
		this.o2oTip = o2oTip;
	}
	public String getO2oorderTotalPrice() {
		return o2oorderTotalPrice;
	}
	public void setO2oorderTotalPrice(String o2oorderTotalPrice) {
		this.o2oorderTotalPrice = o2oorderTotalPrice;
	}
	public String getO2oPayType() {
		return o2oPayType;
	}
	public void setO2oPayType(String o2oPayType) {
		this.o2oPayType = o2oPayType;
	}
	public String getO2oCustomerMsg() {
		return o2oCustomerMsg;
	}
	public void setO2oCustomerMsg(String o2oCustomerMsg) {
		this.o2oCustomerMsg = o2oCustomerMsg;
	}
	public String getO2oDeliveryType() {
		return o2oDeliveryType;
	}
	public void setO2oDeliveryType(String o2oDeliveryType) {
		this.o2oDeliveryType = o2oDeliveryType;
	}
	public String getO2oLogisticsStatus() {
		return o2oLogisticsStatus;
	}
	public void setO2oLogisticsStatus(String o2oLogisticsStatus) {
		this.o2oLogisticsStatus = o2oLogisticsStatus;
	}
	public String getO2oDSRName() {
		return o2oDSRName;
	}
	public void setO2oDSRName(String o2oDSRName) {
		this.o2oDSRName = o2oDSRName;
	}
	public String getO2oDSRCode() {
		return o2oDSRCode;
	}
	public void setO2oDSRCode(String o2oDSRCode) {
		this.o2oDSRCode = o2oDSRCode;
	}
	public String getO2oStoreCellphone() {
		return o2oStoreCellphone;
	}
	public void setO2oStoreCellphone(String o2oStoreCellphone) {
		this.o2oStoreCellphone = o2oStoreCellphone;
	}
	public String getO2oDSRStoreType() {
		return o2oDSRStoreType;
	}
	public void setO2oDSRStoreType(String o2oDSRStoreType) {
		this.o2oDSRStoreType = o2oDSRStoreType;
	}
	public String getO2oDeliveryMan() {
		return o2oDeliveryMan;
	}
	public void setO2oDeliveryMan(String o2oDeliveryMan) {
		this.o2oDeliveryMan = o2oDeliveryMan;
	}
	public String getO2oDeliveryManphone() {
		return o2oDeliveryManphone;
	}
	public void setO2oDeliveryManphone(String o2oDeliveryManphone) {
		this.o2oDeliveryManphone = o2oDeliveryManphone;
	}
	public String getO2oorderType() {
		return o2oorderType;
	}
	public void setO2oorderType(String o2oorderType) {
		this.o2oorderType = o2oorderType;
	}
	public String getO2oIsForcedPickup() {
		return o2oIsForcedPickup;
	}
	public void setO2oIsForcedPickup(String o2oIsForcedPickup) {
		this.o2oIsForcedPickup = o2oIsForcedPickup;
	}
	public String getO2oIsGroPurorder() {
		return o2oIsGroPurorder;
	}
	public void setO2oIsGroPurorder(String o2oIsGroPurorder) {
		this.o2oIsGroPurorder = o2oIsGroPurorder;
	}
	public String getO2oCheckCode() {
		return o2oCheckCode;
	}
	public void setO2oCheckCode(String o2oCheckCode) {
		this.o2oCheckCode = o2oCheckCode;
	}
	public String getO2oCheckStatus() {
		return o2oCheckStatus;
	}
	public void setO2oCheckStatus(String o2oCheckStatus) {
		this.o2oCheckStatus = o2oCheckStatus;
	}

	public String getO2oPayBillTime() {
		return o2oPayBillTime;
	}
	public void setO2oPayBillTime(String o2oPayBillTime) {
		this.o2oPayBillTime = o2oPayBillTime;
	}
	public String getO2oorderPickedT() {
		return o2oorderPickedT;
	}
	public void setO2oorderPickedT(String o2oorderPickedT) {
		this.o2oorderPickedT = o2oorderPickedT;
	}
	public String getO2oStartDeliveryT() {
		return o2oStartDeliveryT;
	}
	public void setO2oStartDeliveryT(String o2oStartDeliveryT) {
		this.o2oStartDeliveryT = o2oStartDeliveryT;
	}
	public String getO2oReceivedTime() {
		return o2oReceivedTime;
	}
	public void setO2oReceivedTime(String o2oReceivedTime) {
		this.o2oReceivedTime = o2oReceivedTime;
	}
	public String getO2oorderStatus() {
		return o2oorderStatus;
	}
	public void setO2oorderStatus(String o2oorderStatus) {
		this.o2oorderStatus = o2oorderStatus;
	}
	public String getO2oorderSourceSystem() {
		return o2oorderSourceSystem;
	}
	public void setO2oorderSourceSystem(String o2oorderSourceSystem) {
		this.o2oorderSourceSystem = o2oorderSourceSystem;
	}
	public String getOrderType() {
		return orderType;
	}
	public void setOrderType(String orderType) {
		this.orderType = orderType;
	}
	public String getO2oiso2oorder() {
		return o2oiso2oorder;
	}
	public void setO2oiso2oorder(String o2oiso2oorder) {
		this.o2oiso2oorder = o2oiso2oorder;
	}
	public String getO2o1stPushTime() {
		return o2o1stPushTime;
	}
	public void setO2o1stPushTime(String o2o1stPushTime) {
		this.o2o1stPushTime = o2o1stPushTime;
	}
	public String getO2o2ndPushTime() {
		return o2o2ndPushTime;
	}
	public void setO2o2ndPushTime(String o2o2ndPushTime) {
		this.o2o2ndPushTime = o2o2ndPushTime;
	}
	public String getO2o3rdPushTime() {
		return o2o3rdPushTime;
	}
	public void setO2o3rdPushTime(String o2o3rdPushTime) {
		this.o2o3rdPushTime = o2o3rdPushTime;
	}
	public String getOrderCreated() {
		return orderCreated;
	}
	public void setOrderCreated(String orderCreated) {
		this.orderCreated = orderCreated;
	}
	public String getOrderHeaderId() {
		return orderHeaderId;
	}
	public void setOrderHeaderId(String orderHeaderId) {
		this.orderHeaderId = orderHeaderId;
	}
	public String getUserRefundUrl() {
		return AppConstants.portalUserRefundUrl;
	}
	
}
