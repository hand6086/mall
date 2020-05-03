package com.hand.base.charts.model;

import com.hand.base.basic.model.BasicModel;

/**
 * 活动支付转化率报表
 * @author lijie
 *
 */

public class ActivityPaymentConversion extends BasicModel{
	
	/**
	 * 活动支付转化率报表
	 */
	private static final long serialVersionUID = 4917617664453068327L;
	
	private String startTime;//开始时间
	private String endTime;//结束时间
	private String activityName;//活动名称
	private String pV;//不去重次数
	private String uV;//去重复次数
	private String orderBuyersNumber;//下单买家数
	private String orderSumMoney;//下单总金额
	private String paymentBuyersNumber;//支付买家数
	private String paymentSumMoney;//支付总金额
	private String paymentAveragePrice;//客单价
	
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
	public String getActivityName() {
		return activityName;
	}
	public void setActivityName(String activityName) {
		this.activityName = activityName;
	}
	public String getpV() {
		return pV;
	}
	public void setpV(String pV) {
		this.pV = pV;
	}
	public String getuV() {
		return uV;
	}
	public void setuV(String uV) {
		this.uV = uV;
	}
	public String getOrderBuyersNumber() {
		return orderBuyersNumber;
	}
	public void setOrderBuyersNumber(String orderBuyersNumber) {
		this.orderBuyersNumber = orderBuyersNumber;
	}
	public String getOrderSumMoney() {
		return orderSumMoney;
	}
	public void setOrderSumMoney(String orderSumMoney) {
		this.orderSumMoney = orderSumMoney;
	}
	public String getPaymentBuyersNumber() {
		return paymentBuyersNumber;
	}
	public void setPaymentBuyersNumber(String paymentBuyersNumber) {
		this.paymentBuyersNumber = paymentBuyersNumber;
	}
	public String getPaymentSumMoney() {
		return paymentSumMoney;
	}
	public void setPaymentSumMoney(String paymentSumMoney) {
		this.paymentSumMoney = paymentSumMoney;
	}
	public String getPaymentAveragePrice() {
		return paymentAveragePrice;
	}
	public void setPaymentAveragePrice(String paymentAveragePrice) {
		this.paymentAveragePrice = paymentAveragePrice;
	}
	
	
}
