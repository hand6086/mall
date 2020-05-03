package com.hand.base.promotion.model;

import com.hand.base.basic.model.BasicModel;

/**
 * 拼团人员
 * 
 * @author guo
 *
 */
public class GroupUser extends BasicModel {

	private static final long serialVersionUID = 9108094911189885195L;

	/**
	 * 拼团 团ID
	 */
	private String groupId;

	/**
	 * 入团时间
	 */
	private String startTime;

	/**
	 * 消费者ID
	 */
	private String customerId;

	/**
	 * 是否发起人标志
	 */
	private String foundFlg;

	/**
	 * 消费者编码
	 */
	private String payFlg;

	/**
	 * 消费者电话
	 */
	private String customerCode;

	/**
	 * 消费者名称
	 */
	private String phoneNumber;

	/**
	 * 支付标志
	 */
	private String customerName;

	/**
	 * 订单编号
	 */
	private String orderNum;

	public String getGroupId() {
		return groupId;
	}

	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getCustomerId() {
		return customerId;
	}

	public void setCustomerId(String customerId) {
		this.customerId = customerId;
	}

	public String getFoundFlg() {
		return foundFlg;
	}

	public void setFoundFlg(String foundFlg) {
		this.foundFlg = foundFlg;
	}

	public String getPayFlg() {
		return payFlg;
	}

	public void setPayFlg(String payFlg) {
		this.payFlg = payFlg;
	}

	public String getCustomerCode() {
		return customerCode;
	}

	public void setCustomerCode(String customerCode) {
		this.customerCode = customerCode;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public String getOrderNum() {
		return orderNum;
	}

	public void setOrderNum(String orderNum) {
		this.orderNum = orderNum;
	}

}
