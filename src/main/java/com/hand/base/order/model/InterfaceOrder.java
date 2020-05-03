package com.hand.base.order.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * 
 * @author 接口订单
 *
 */
public class InterfaceOrder implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 4249701720109129770L;
	
	private List<InterfaceOrderLine> interfaceOrderLineList = new ArrayList<InterfaceOrderLine>();
	
	public List<InterfaceOrderLine> getInterfaceOrderLineList() {
		return interfaceOrderLineList;
	}
	public void setInterfaceOrderLineList(List<InterfaceOrderLine> interfaceOrderLineList) {
		this.interfaceOrderLineList = interfaceOrderLineList;
	}
	private String id;
	private String corpid;

	private String orderNum;// 订单编号（主键）
	private String customerName;// 消费者用户名
	private String contact;// 收货人
	private String province;// 省
	private String city;// 市
	private String district;// 区／县
	private String address;// 详细地址
	private String contactPhone;// 联系电话
	private String businessName;// 商户名称
	private String orderStatus;// 订单状态
	private String orderTime;// 下单时间
	private String orderAmount;// 订单总金额
	private String payType;// 支付方式
	private String payTime;// 付款时间
	private String logisticsStatus;// 物流状态
	private String logisticsCompany;// 物流公司
	private String logisticsNum;// 物流单号
	private String shippingTime;// 发运时间
	private String allDiscountAmount;// 优惠总金额
	private String customerComments;// 买家留言
	private String cancelTime;// 取消时间
	private String gightGroups;// 拼团名称
	private String couponAmount;// 优惠券金额
	private String orderComments;// 订单备注
	private String logisticsPayAmount;// 总运费
	
	private String startTime;
	private String endTime;
	private int startRow;
	private int endRow;
	
	private int queryRow;
	
	public int getQueryRow() {
		return this.endRow - this.startRow;
	}
	public void setQueryRow(int queryRow) {
		this.queryRow = queryRow;
	}
	public int getStartRow() {
		return startRow;
	}
	public void setStartRow(int startRow) {
		this.startRow = startRow;
	}
	public int getEndRow() {
		return endRow;
	}
	public void setEndRow(int endRow) {
		this.endRow = endRow;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getCorpid() {
		return corpid;
	}
	public void setCorpid(String corpid) {
		this.corpid = corpid;
	}
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
	public String getContact() {
		return contact;
	}
	public void setContact(String contact) {
		this.contact = contact;
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
	public String getContactPhone() {
		return contactPhone;
	}
	public void setContactPhone(String contactPhone) {
		this.contactPhone = contactPhone;
	}
	public String getBusinessName() {
		return businessName;
	}
	public void setBusinessName(String businessName) {
		this.businessName = businessName;
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
	public String getOrderAmount() {
		return orderAmount;
	}
	public void setOrderAmount(String orderAmount) {
		this.orderAmount = orderAmount;
	}
	public String getPayType() {
		return payType;
	}
	public void setPayType(String payType) {
		this.payType = payType;
	}
	public String getPayTime() {
		return payTime;
	}
	public void setPayTime(String payTime) {
		this.payTime = payTime;
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
	public String getLogisticsNum() {
		return logisticsNum;
	}
	public void setLogisticsNum(String logisticsNum) {
		this.logisticsNum = logisticsNum;
	}
	public String getShippingTime() {
		return shippingTime;
	}
	public void setShippingTime(String shippingTime) {
		this.shippingTime = shippingTime;
	}
	public String getAllDiscountAmount() {
		return allDiscountAmount;
	}
	public void setAllDiscountAmount(String allDiscountAmount) {
		this.allDiscountAmount = allDiscountAmount;
	}
	public String getCustomerComments() {
		return customerComments;
	}
	public void setCustomerComments(String customerComments) {
		this.customerComments = customerComments;
	}
	public String getCancelTime() {
		return cancelTime;
	}
	public void setCancelTime(String cancelTime) {
		this.cancelTime = cancelTime;
	}
	public String getGightGroups() {
		return gightGroups;
	}
	public void setGightGroups(String gightGroups) {
		this.gightGroups = gightGroups;
	}
	public String getCouponAmount() {
		return couponAmount;
	}
	public void setCouponAmount(String couponAmount) {
		this.couponAmount = couponAmount;
	}
	public String getOrderComments() {
		return orderComments;
	}
	public void setOrderComments(String orderComments) {
		this.orderComments = orderComments;
	}
	public String getLogisticsPayAmount() {
		return logisticsPayAmount;
	}
	public void setLogisticsPayAmount(String logisticsPayAmount) {
		this.logisticsPayAmount = logisticsPayAmount;
	}

}
