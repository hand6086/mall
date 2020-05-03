package com.hand.base.charts.model;

import com.hand.base.basic.model.BasicModel;

/**
 * 品牌馆订单发货分析
 * @author lijie
 *
 */

public class BrandOrderDeliveryAnalysis extends BasicModel{
	
	/**
	 * 品牌馆订单发货分析
	 */
	private static final long serialVersionUID = 4917617664453068327L;
	
	private String startTime;//开始时间
	private String endTime;//结束时间
	private String merchName;//商家名称
	private String orderNumber;//订单数量
	private String waitDelivery;//订单待发货数量
	private String unshippedDelivery;//48小时内未发货订单数量
	private String unshippedDeliveryLong;//48小时及以上未发货订单数量
	private String waitSign;//订单已发货待签收数量
	private String completeNumber;//订单交易完成数量
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
	public String getOrderNumber() {
		return orderNumber;
	}
	public void setOrderNumber(String orderNumber) {
		this.orderNumber = orderNumber;
	}
	public String getWaitDelivery() {
		return waitDelivery;
	}
	public void setWaitDelivery(String waitDelivery) {
		this.waitDelivery = waitDelivery;
	}
	public String getUnshippedDelivery() {
		return unshippedDelivery;
	}
	public void setUnshippedDelivery(String unshippedDelivery) {
		this.unshippedDelivery = unshippedDelivery;
	}
	public String getUnshippedDeliveryLong() {
		return unshippedDeliveryLong;
	}
	public void setUnshippedDeliveryLong(String unshippedDeliveryLong) {
		this.unshippedDeliveryLong = unshippedDeliveryLong;
	}
	public String getWaitSign() {
		return waitSign;
	}
	public void setWaitSign(String waitSign) {
		this.waitSign = waitSign;
	}
	public String getCompleteNumber() {
		return completeNumber;
	}
	public void setCompleteNumber(String completeNumber) {
		this.completeNumber = completeNumber;
	}
	
	
	
}
