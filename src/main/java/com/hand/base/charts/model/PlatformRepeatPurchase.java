package com.hand.base.charts.model;

import com.hand.base.basic.model.BasicModel;

/**
 * 平台复购率报表
 * @author lijie
 *
 */

public class PlatformRepeatPurchase extends BasicModel{
	
	
	/**
	 * 平台复购率报表
	 */
	private static final long serialVersionUID = 1L;
	
	private String startTime;  //开始时间
	private String endTime;    //结束时间
	private String chooseType;  //频道选择
	private String purchaseTimes;  //购买次数
	private String buyersNumber;  //买家数量
	private String repeatPurchaseProportion;  //复购人数占比
	
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
	public String getChooseType() {
		return chooseType;
	}
	public void setChooseType(String chooseType) {
		this.chooseType = chooseType;
	}
	public String getPurchaseTimes() {
		return purchaseTimes;
	}
	public void setPurchaseTimes(String purchaseTimes) {
		this.purchaseTimes = purchaseTimes;
	}
	public String getBuyersNumber() {
		return buyersNumber;
	}
	public void setBuyersNumber(String buyersNumber) {
		this.buyersNumber = buyersNumber;
	}
	public String getRepeatPurchaseProportion() {
		return repeatPurchaseProportion;
	}
	public void setRepeatPurchaseProportion(String repeatPurchaseProportion) {
		this.repeatPurchaseProportion = repeatPurchaseProportion;
	}
	
}
