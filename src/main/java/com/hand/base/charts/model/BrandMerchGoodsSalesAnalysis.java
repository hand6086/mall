package com.hand.base.charts.model;

import com.hand.base.basic.model.BasicModel;

/**
 * 品牌馆商家商品销量、销售额分析
 * @author lijie
 *
 */

public class BrandMerchGoodsSalesAnalysis extends BasicModel{
	
	/**
	 * 品牌馆商家商品销量、销售额分析
	 */
	private static final long serialVersionUID = 4917617664453068327L;
	
	private String startTime;//开始时间
	private String endTime;//结束时间
	private String merchName;//商家名称
	private String goodsName;//商品名称
	private String saleNumber;//销量
	private String saleMoney;//销售额
	private String dealMoney;//总成交金额
	
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
	public String getSaleNumber() {
		return saleNumber;
	}
	public void setSaleNumber(String saleNumber) {
		this.saleNumber = saleNumber;
	}
	public String getSaleMoney() {
		return saleMoney;
	}
	public void setSaleMoney(String saleMoney) {
		this.saleMoney = saleMoney;
	}
	public String getDealMoney() {
		return dealMoney;
	}
	public void setDealMoney(String dealMoney) {
		this.dealMoney = dealMoney;
	}
	
}
