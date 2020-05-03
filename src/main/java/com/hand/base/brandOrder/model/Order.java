package com.hand.base.brandOrder.model;

import java.math.BigDecimal;
import java.util.List;

import com.hand.base.basic.model.BasicModel;

public class Order extends BasicModel {
	
	/**
	 * 订单头
	 */
	private static final long serialVersionUID = 6297400368920826928L;
	
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
	private BigDecimal  orderTotalPrice;     /*订单总金额*/
	private String  o2oPayType;          /*支付方式*/
	private String  attrib26; 				/*付款时间*/
	private String  logisticsStatus;     /*物流状态*/
	private String  logisticsCompany;	 /*物流公司*/
	private String  logisticsOddNumber;  /*物流单号*/
	private String  shippingTime;		/*发运时间*/
	private BigDecimal  tAttr20;             /*优惠券金额*/
	private BigDecimal  offerSum; 			 /*优惠总金额*/
	private String  customerMsg;         /*买家留言*/
	private String  refuseRefundDate;   /*取消时间*/
	private String  cancelReason;   	/*取消原因*/
	private String  fightGroupsId;       /*拼团id*/
	private String  couponId;            /*优惠券id*/
	private BigDecimal  freight;             /*运费*/
	private String  receiveTime;            /*签收时间*/
	private String  afterSaleCycle;            /*售后周期*/
	private List<OrderItem>  orderItem; /*订单行*/
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
	public String getStoreName() {
		return storeName;
	}
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
	public BigDecimal getOrderTotalPrice() {
		return orderTotalPrice;
	}
	public void setOrderTotalPrice(BigDecimal orderTotalPrice) {
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
	public BigDecimal gettAttr20() {
		return tAttr20;
	}
	public void settAttr20(BigDecimal tAttr20) {
		this.tAttr20 = tAttr20;
	}
	public BigDecimal getOfferSum() {
		return offerSum;
	}
	public void setOfferSum(BigDecimal offerSum) {
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
	public BigDecimal getFreight() {
		return freight;
	}
	public void setFreight(BigDecimal freight) {
		this.freight = freight;
	}
	public List<OrderItem> getOrderItem() {
		return orderItem;
	}
	public void setOrderItem(List<OrderItem> orderItem) {
		this.orderItem = orderItem;
	}

	public String getReceiveTime() {
		return receiveTime;
	}

	public void setReceiveTime(String receiveTime) {
		this.receiveTime = receiveTime;
	}

	public String getAfterSaleCycle() {
		return afterSaleCycle;
	}

	public void setAfterSaleCycle(String afterSaleCycle) {
		this.afterSaleCycle = afterSaleCycle;
	}
}
