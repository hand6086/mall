package com.hand.base.charts.model;

import com.hand.base.basic.model.BasicModel;

/**
 * 品牌馆商家售后分析统计
 * @author lijie
 *
 */

public class BrandMerchAfterSalesAnalysis extends BasicModel{
	
	/**
	 * 品牌馆商家售后分析统计
	 */
	private static final long serialVersionUID = 4917617664453068327L;
	
	private String startTime;//开始时间
	private String endTime;//结束时间
	private String merchName;//商家名称
	private String afterSaleType;	//售后类型
	private String afterSaleState;	//售后状态
	private String applyNumber;	//申请数量
	private String sumMoney;	//售后总金额
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
	public String getAfterSaleType() {
		return afterSaleType;
	}
	public void setAfterSaleType(String afterSaleType) {
		this.afterSaleType = afterSaleType;
	}
	public String getAfterSaleState() {
		return afterSaleState;
	}
	public void setAfterSaleState(String afterSaleState) {
		this.afterSaleState = afterSaleState;
	}
	public String getApplyNumber() {
		return applyNumber;
	}
	public void setApplyNumber(String applyNumber) {
		this.applyNumber = applyNumber;
	}
	public String getSumMoney() {
		return sumMoney;
	}
	public void setSumMoney(String sumMoney) {
		this.sumMoney = sumMoney;
	}
	
	
}
