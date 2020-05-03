package com.hand.base.charts.model;

import com.hand.base.basic.model.BasicModel;

/**
 * 品牌馆商家订单关闭（取消、售后）统计
 * @author lijie
 *
 */

public class BrandMerchOrderCloseStatistics extends BasicModel{
	
	/**
	 * 品牌馆商家订单关闭（取消、售后）统计
	 */
	private static final long serialVersionUID = 4917617664453068327L;
	
	private String startTime;//开始时间
	private String endTime;//结束时间
	private String merchName;//商家名称
	private String orderCloseCause;//订单关闭原因
	private String orderStatus;//订单状态
	private String orderNumber;//订单数量
	
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
	public String getOrderCloseCause() {
		return orderCloseCause;
	}
	public void setOrderCloseCause(String orderCloseCause) {
		this.orderCloseCause = orderCloseCause;
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
	
}
