package com.hand.base.order.model;

import java.io.Serializable;

/**
 * 
 * @author 接口订单行
 *
 */
public class InterfaceOrderLine implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 273040180550299431L;
	
	private String lineId;//行号（主键）
	private String productName;//商品名称
	private String productCode;//商品条码
	private String marketPrice;//报价
	private String qtyReq;//数量
	private String marketPriceAmount;//报价总金额
	private String dealPrice;//成交价
	private String dealPriceAmount;//成交总金额
	private String giftFlag;//是否赠品
	private String promotionName;//促销活动名称
	private String itemDiscountAmount;//优惠总金额
	private String couponName;//优惠券名称
	private String couponDiscount;//优惠券抵扣金额
	private String logisticsPay;//商品运费
	private String orderId;//订单Id
	public String getLineId() {
		return lineId;
	}
	public void setLineId(String lineId) {
		this.lineId = lineId;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getProductCode() {
		return productCode;
	}
	public void setProductCode(String productCode) {
		this.productCode = productCode;
	}
	public String getMarketPrice() {
		return marketPrice;
	}
	public void setMarketPrice(String marketPrice) {
		this.marketPrice = marketPrice;
	}
	public String getQtyReq() {
		return qtyReq;
	}
	public void setQtyReq(String qtyReq) {
		this.qtyReq = qtyReq;
	}
	public String getMarketPriceAmount() {
		return marketPriceAmount;
	}
	public void setMarketPriceAmount(String marketPriceAmount) {
		this.marketPriceAmount = marketPriceAmount;
	}
	public String getDealPrice() {
		return dealPrice;
	}
	public void setDealPrice(String dealPrice) {
		this.dealPrice = dealPrice;
	}
	public String getDealPriceAmount() {
		return dealPriceAmount;
	}
	public void setDealPriceAmount(String dealPriceAmount) {
		this.dealPriceAmount = dealPriceAmount;
	}
	public String getGiftFlag() {
		return giftFlag;
	}
	public void setGiftFlag(String giftFlag) {
		this.giftFlag = giftFlag;
	}
	public String getPromotionName() {
		return promotionName;
	}
	public void setPromotionName(String promotionName) {
		this.promotionName = promotionName;
	}
	public String getItemDiscountAmount() {
		return itemDiscountAmount;
	}
	public void setItemDiscountAmount(String itemDiscountAmount) {
		this.itemDiscountAmount = itemDiscountAmount;
	}
	public String getCouponName() {
		return couponName;
	}
	public void setCouponName(String couponName) {
		this.couponName = couponName;
	}
	public String getCouponDiscount() {
		return couponDiscount;
	}
	public void setCouponDiscount(String couponDiscount) {
		this.couponDiscount = couponDiscount;
	}
	public String getLogisticsPay() {
		return logisticsPay;
	}
	public void setLogisticsPay(String logisticsPay) {
		this.logisticsPay = logisticsPay;
	}
	public String getOrderId() {
		return orderId;
	}
	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
}
