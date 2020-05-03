package com.hand.base.charts.model;

import com.hand.base.basic.model.BasicModel;

/**
 * 商品复购率报表
 * @author lijie
 *
 */

public class GoodsRepeatPurchase extends BasicModel{
	
	
	/**
	 * 商品复购率报表
	 */
	private static final long serialVersionUID = 1L;
	
	private String startTime;  //开始时间
	private String endTime;    //结束时间
	private String merchName;  //商家名称
	private String goodsName;  //商品名称
	private String goodsRepeatBuyers;  //商品复购买家数
	private String sumBuyers;  //商品总买家数
	private String repeatPurchase;  //复购率
	
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
	public String getGoodsName() {
		return goodsName;
	}
	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}
	public String getGoodsRepeatBuyers() {
		return goodsRepeatBuyers;
	}
	public void setGoodsRepeatBuyers(String goodsRepeatBuyers) {
		this.goodsRepeatBuyers = goodsRepeatBuyers;
	}
	public String getSumBuyers() {
		return sumBuyers;
	}
	public void setSumBuyers(String sumBuyers) {
		this.sumBuyers = sumBuyers;
	}
	public String getRepeatPurchase() {
		return repeatPurchase;
	}
	public void setRepeatPurchase(String repeatPurchase) {
		this.repeatPurchase = repeatPurchase;
	}
	
}
