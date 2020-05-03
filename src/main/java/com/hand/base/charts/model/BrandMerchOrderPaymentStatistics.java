package com.hand.base.charts.model;

import com.hand.base.basic.model.BasicModel;

/**
 * 品牌馆商家订单支付统计
 * @author lijie
 *
 */

public class BrandMerchOrderPaymentStatistics extends BasicModel{
	
	/**
	 * 品牌馆商家订单支付统计
	 */
	private static final long serialVersionUID = 4917617664453068327L;
	private String startTime;//开始时间
	private String endTime;//结束时间
	private String merchName;//商家名称
	private String orderStatus;//订单状态
	private String orderNumber;//订单数量
	private String amountMoney;//报价总金额
	private String amountDiscountMoney;//总优惠金额
	private String amountDealMoney;//总成交金额
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
	public String getMerchName() {
		return merchName;
	}
	public void setMerchName(String merchName) {
		this.merchName = merchName;
	}
	public String getOrderStatus() {
		return orderStatus;
	}
	public void setOrderStatus(String orderStatus) {
		this.orderStatus = orderStatus;
	}
	public String getOrderNumber() {
		return orderNumber;
	}
	public void setOrderNumber(String orderNumber) {
		this.orderNumber = orderNumber;
	}
	public String getAmountMoney() {
		return amountMoney;
	}
	public void setAmountMoney(String amountMoney) {
		this.amountMoney = amountMoney;
	}
	public String getAmountDiscountMoney() {
		return amountDiscountMoney;
	}
	public void setAmountDiscountMoney(String amountDiscountMoney) {
		this.amountDiscountMoney = amountDiscountMoney;
	}
	public String getAmountDealMoney() {
		return amountDealMoney;
	}
	public void setAmountDealMoney(String amountDealMoney) {
		this.amountDealMoney = amountDealMoney;
	}
	
}
