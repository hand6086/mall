package com.hand.base.brandOrder.model;

import com.hand.base.basic.model.BasicModel;

import java.math.BigDecimal;

public class OrderExport extends BasicModel {

	/**
	 * 订单行
	 */
	private static final long serialVersionUID = -8435507763991521008L;

	private String  orderNum;            /*订单编号*/
	private String  customerName;         /*消费者名称*/
	private String  customerId;         /*消费者Id*/
	private String  mainPhNum;         /*消费者名称*/
	private String  recieverName;		 /*收货人姓名*/
	private String  province;            /*省（收货地址）*/
	private String  city;                /*城市（收货地址）*/
	private String  district;            /*区县（收货地址）*/
	private String  address;	         /*详细地址（收货地址）*/
	private String  addressAll;	         /*全部地址（收货地址）*/
	private String  recieverPhone;	     /*收货人电话*/
	private String  storeName;           /*商户名称*/
	private String  orderStatus;         /*订单状态*/
	private String  orderTime;           /*下单时间*/
	private String  orderTotalPrice;     /*订单总金额*/
	private String  o2oPayType;          /*支付方式*/
	private String  attrib26; 				/*付款时间*/
	private String  logisticsStatus;     /*物流状态*/
	private String  logisticsCompany;	 /*物流公司*/
	private String  logisticsOddNumber;  /*物流单号*/
	private String  shippingTime;		/*发运时间*/
	private String  tAttr20;             /*优惠券金额*/
	private String  offerSum; 			 /*优惠总金额*/
	private String  customerMsg;         /*买家留言*/
	private String  refuseRefundDate;   /*取消时间*/
	private String  cancelReason;   	/*取消原因*/
	private String  fightGroupsId;       /*拼团id*/
	private String  couponId;            /*优惠券id*/
	private String  freight;             /*运费*/
	private String   	 merchName;			 /* 商品名字 */
	private String  	 productCode;			 /* 商品编码 */
	private String   price;               /*报价*/
	private String   qty;                 /*数量*/
	private String   qtyAftersale;        /*售后数量*/
	private String   attrib17;            /*报价总金额*/
	private String   pmoPrice;            /*成交价*/
	private String   tAttr19;             /*成交价总金额*/
	private String  	 attrib11;            /*是否赠品*/
	private String  	 campId;              /*活动id*/
	private String  	 activityName;		  /*活动名称*/
	private String   merchantOfferSum;    /*商品优惠金额*/

	public String getOrderNum() {
		return orderNum;
	}

	public void setOrderNum(String orderNum) {
		this.orderNum = orderNum;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public String getCustomerId() {
		return customerId;
	}

	public void setCustomerId(String customerId) {
		this.customerId = customerId;
	}

	public String getMainPhNum() {
		return mainPhNum;
	}

	public void setMainPhNum(String mainPhNum) {
		this.mainPhNum = mainPhNum;
	}

	public String getRecieverName() {
		return recieverName;
	}

	public void setRecieverName(String recieverName) {
		this.recieverName = recieverName;
	}

	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getDistrict() {
		return district;
	}

	public void setDistrict(String district) {
		this.district = district;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getAddressAll() {
		return addressAll;
	}

	public void setAddressAll(String addressAll) {
		this.addressAll = addressAll;
	}

	public String getRecieverPhone() {
		return recieverPhone;
	}

	public void setRecieverPhone(String recieverPhone) {
		this.recieverPhone = recieverPhone;
	}

	@Override
	public String getStoreName() {
		return storeName;
	}

	@Override
	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}

	public String getOrderStatus() {
		return orderStatus;
	}

	public void setOrderStatus(String orderStatus) {
		this.orderStatus = orderStatus;
	}

	public String getOrderTime() {
		return orderTime;
	}

	public void setOrderTime(String orderTime) {
		this.orderTime = orderTime;
	}

	public String getOrderTotalPrice() {
		return orderTotalPrice;
	}

	public void setOrderTotalPrice(String orderTotalPrice) {
		this.orderTotalPrice = orderTotalPrice;
	}

	public String getO2oPayType() {
		return o2oPayType;
	}

	public void setO2oPayType(String o2oPayType) {
		this.o2oPayType = o2oPayType;
	}

	public String getAttrib26() {
		return attrib26;
	}

	public void setAttrib26(String attrib26) {
		this.attrib26 = attrib26;
	}

	public String getLogisticsStatus() {
		return logisticsStatus;
	}

	public void setLogisticsStatus(String logisticsStatus) {
		this.logisticsStatus = logisticsStatus;
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

	public String gettAttr20() {
		return tAttr20;
	}

	public void settAttr20(String tAttr20) {
		this.tAttr20 = tAttr20;
	}

	public String getOfferSum() {
		return offerSum;
	}

	public void setOfferSum(String offerSum) {
		this.offerSum = offerSum;
	}

	public String getCustomerMsg() {
		return customerMsg;
	}

	public void setCustomerMsg(String customerMsg) {
		this.customerMsg = customerMsg;
	}

	public String getRefuseRefundDate() {
		return refuseRefundDate;
	}

	public void setRefuseRefundDate(String refuseRefundDate) {
		this.refuseRefundDate = refuseRefundDate;
	}

	public String getCancelReason() {
		return cancelReason;
	}

	public void setCancelReason(String cancelReason) {
		this.cancelReason = cancelReason;
	}

	public String getFightGroupsId() {
		return fightGroupsId;
	}

	public void setFightGroupsId(String fightGroupsId) {
		this.fightGroupsId = fightGroupsId;
	}

	public String getCouponId() {
		return couponId;
	}

	public void setCouponId(String couponId) {
		this.couponId = couponId;
	}

	public String getFreight() {
		return freight;
	}

	public void setFreight(String freight) {
		this.freight = freight;
	}

	public String getMerchName() {
		return merchName;
	}

	public void setMerchName(String merchName) {
		this.merchName = merchName;
	}

	public String getProductCode() {
		return productCode;
	}

	public void setProductCode(String productCode) {
		this.productCode = productCode;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getQty() {
		return qty;
	}

	public void setQty(String qty) {
		this.qty = qty;
	}

	public String getQtyAftersale() {
		return qtyAftersale;
	}

	public void setQtyAftersale(String qtyAftersale) {
		this.qtyAftersale = qtyAftersale;
	}

	public String getAttrib17() {
		return attrib17;
	}

	public void setAttrib17(String attrib17) {
		this.attrib17 = attrib17;
	}

	public String getPmoPrice() {
		return pmoPrice;
	}

	public void setPmoPrice(String pmoPrice) {
		this.pmoPrice = pmoPrice;
	}

	public String gettAttr19() {
		return tAttr19;
	}

	public void settAttr19(String tAttr19) {
		this.tAttr19 = tAttr19;
	}

	public String getAttrib11() {
		return attrib11;
	}

	public void setAttrib11(String attrib11) {
		this.attrib11 = attrib11;
	}

	public String getCampId() {
		return campId;
	}

	public void setCampId(String campId) {
		this.campId = campId;
	}

	public String getActivityName() {
		return activityName;
	}

	public void setActivityName(String activityName) {
		this.activityName = activityName;
	}

	public String getMerchantOfferSum() {
		return merchantOfferSum;
	}

	public void setMerchantOfferSum(String merchantOfferSum) {
		this.merchantOfferSum = merchantOfferSum;
	}
}
