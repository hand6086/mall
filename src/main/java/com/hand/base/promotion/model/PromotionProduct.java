package com.hand.base.promotion.model;

import java.util.Date;

import com.hand.base.basic.model.BasicModel;

public class PromotionProduct extends BasicModel {

	private static final long serialVersionUID = 5662287376865948584L;

	private String activityName;/* 活动名称 */
	private String type;/* 促销类型 */
	private String buyMerchName;/* 商品名称 */
	private String merchCode;/* 商品编码 */
	private float promotionPrice;/* 活动价 */
	private int totalQty;/* 限购总量 */
	private int purchasedQty;/* 已售数量 */
	private int lmtAmt;/* 单人限购数量 */
	private String status;/* 商品状态 */
	private Date startTime;/* 商品开始时间 */
	private Date endTime; /* 商品结束时间 */
	private String rowId; /* 商品结束时间 */
	private int displaySeq; /* 显示顺序 */
	private String cityName; /* 城市名 */

	public String getActivityName() {
		return activityName;
	}

	public void setActivityName(String activityName) {
		this.activityName = activityName;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getBuyMerchName() {
		return buyMerchName;
	}

	public void setBuyMerchName(String buyMerchName) {
		this.buyMerchName = buyMerchName;
	}

	public String getMerchCode() {
		return merchCode;
	}

	public void setMerchCode(String merchCode) {
		this.merchCode = merchCode;
	}

	public float getPromotionPrice() {
		return promotionPrice;
	}

	public void setPromotionPrice(float promotionPrice) {
		this.promotionPrice = promotionPrice;
	}

	public int getTotalQty() {
		return totalQty;
	}

	public void setTotalQty(int totalQty) {
		this.totalQty = totalQty;
	}

	public int getPurchasedQty() {
		return purchasedQty;
	}

	public void setPurchasedQty(int purchasedQty) {
		this.purchasedQty = purchasedQty;
	}

	public int getLmtAmt() {
		return lmtAmt;
	}

	public void setLmtAmt(int lmtAmt) {
		this.lmtAmt = lmtAmt;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Date getStartTime() {
		return startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public String getRowId() {
		return rowId;
	}

	public void setRowId(String rowId) {
		this.rowId = rowId;
	}

	public int getDisplaySeq() {
		return displaySeq;
	}

	public void setDisplaySeq(int displaySeq) {
		this.displaySeq = displaySeq;
	}

	public String getCityName() {
		return cityName;
	}

	public void setCityName(String cityName) {
		this.cityName = cityName;
	}

}
