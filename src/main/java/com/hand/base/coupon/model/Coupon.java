package com.hand.base.coupon.model;

import java.math.BigDecimal;

import com.hand.base.basic.model.BasicModel;

public class Coupon extends BasicModel {
	/**
	 * 优惠卷
	 */
	private static final long serialVersionUID = 5164338061090861404L;
	private String headId;
	private String merchName;
	private String merchCode;
	private String couponName;
	private String couponCode;
	private String faceValue;
	private String startTime;
	private String endTime;
	private String restriction;
	private String minOrdPrice;
	private String limitreceived;
	private String limitStarted;
	private String limitFinish;
	private String releaseAmt;
	private String amtPerConsumer;
	private String drawType;
	private String couponStatus;
	private String couponType;
	private String goodsAvailable;
	private String receivedQuantity;
	private String costProportionD;
	private String costMaxProportionD;
	private String costMinProportionD;
	private String costProportionW;
	private String costMaxProportionW;
	private String costMinProportionW;
	private String costProportionR;
	private String costMaxProportionR;
	private String costMinProportionR;
	private String cityId;
	private String cityName;
	private String customerName;
	private String customerCode;
	private String couponCity;
	private String actualCity;
	private String coupontatus;
	private String isUsed;
	private String drawTime;
	private String notes;
	private String goodsName;
	private String goodsCode;
	private String status;
	private String promotionCodeId;
	private String phone;
	private String customerId;
	private String merchId;
	private String type;
	private BigDecimal usedAmt;// 使用数量
	private String brandCouponStatus;// 品牌馆优惠券状态
	private String deleteFlg;// 页面是否删除标识

	public String getMerchId() {
		return merchId;
	}

	public void setMerchId(String merchId) {
		this.merchId = merchId;
	}

	public String getGoodsCode() {
		return goodsCode;
	}

	public void setGoodsCode(String goodsCode) {
		this.goodsCode = goodsCode;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public String getCustomerCode() {
		return customerCode;
	}

	public void setCustomerCode(String customerCode) {
		this.customerCode = customerCode;
	}

	public String getCouponCity() {
		return couponCity;
	}

	public void setCouponCity(String couponCity) {
		this.couponCity = couponCity;
	}

	public String getActualCity() {
		return actualCity;
	}

	public void setActualCity(String actualCity) {
		this.actualCity = actualCity;
	}

	public String getCoupontatus() {
		return coupontatus;
	}

	public void setCoupontatus(String coupontatus) {
		this.coupontatus = coupontatus;
	}

	public String getIsUsed() {
		return isUsed;
	}

	public void setIsUsed(String isUsed) {
		this.isUsed = isUsed;
	}

	public String getDrawTime() {
		return drawTime;
	}

	public void setDrawTime(String drawTime) {
		this.drawTime = drawTime;
	}

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

	public String getMinOrdPrice() {
		if (minOrdPrice != null) {
			int index = minOrdPrice.indexOf(".");
			if (index > 0 && minOrdPrice.length() >= index + 3) {
				return minOrdPrice.substring(0, index + 3);
			}
		}
		return minOrdPrice;
	}

	public void setMinOrdPrice(String minOrdPrice) {
		this.minOrdPrice = minOrdPrice;
	}

	public String getLimitreceived() {
		if (limitreceived != null) {
			int index = limitreceived.indexOf(".");
			if (index > 0 && limitreceived.length() >= index + 3) {
				return limitreceived.substring(0, index + 3);
			}
		}
		return limitreceived;
	}

	public void setLimitreceived(String limitreceived) {
		this.limitreceived = limitreceived;
	}

	public String getLimitStarted() {
		return limitStarted;
	}

	public void setLimitStarted(String limitStarted) {
		this.limitStarted = limitStarted;
	}

	public String getLimitFinish() {
		return limitFinish;
	}

	public void setLimitFinish(String limitFinish) {
		this.limitFinish = limitFinish;
	}

	public String getReleaseAmt() {
		if (releaseAmt != null && releaseAmt.indexOf(".") > 0) {
			return releaseAmt.substring(0, releaseAmt.indexOf("."));
		}
		return releaseAmt;
	}

	public void setReleaseAmt(String releaseAmt) {
		this.releaseAmt = releaseAmt;
	}

	public String getAmtPerConsumer() {
		if (amtPerConsumer != null && amtPerConsumer.indexOf(".") > 0) {
			return amtPerConsumer.substring(0, amtPerConsumer.indexOf("."));
		}
		return amtPerConsumer;
	}

	public void setAmtPerConsumer(String amtPerConsumer) {
		this.amtPerConsumer = amtPerConsumer;
	}

	public String getDrawType() {
		return drawType;
	}

	public void setDrawType(String drawType) {
		this.drawType = drawType;
	}

	public String getCouponType() {
		return couponType;
	}

	public void setCouponType(String couponType) {
		this.couponType = couponType;
	}

	public String getGoodsAvailable() {
		return goodsAvailable;
	}

	public void setGoodsAvailable(String goodsAvailable) {
		this.goodsAvailable = goodsAvailable;
	}

	public String getReceivedQuantity() {
		if (receivedQuantity != null && receivedQuantity.indexOf(".") > 0) {
			return receivedQuantity.substring(0, receivedQuantity.indexOf("."));
		}
		return receivedQuantity;
	}

	public void setReceivedQuantity(String receivedQuantity) {
		this.receivedQuantity = receivedQuantity;
	}

	public String getCostProportionD() {
		if (costProportionD != null) {
			int index = costProportionD.indexOf(".");
			if (index > 0 && costProportionD.length() >= index + 3) {
				return costProportionD.substring(0, index + 3);
			}
		}
		return costProportionD;
	}

	public void setCostProportionD(String costProportionD) {
		this.costProportionD = costProportionD;
	}

	public String getCostMaxProportionD() {
		if (costMaxProportionD != null) {
			int index = costMaxProportionD.indexOf(".");
			if (index > 0 && costMaxProportionD.length() >= index + 3) {
				return costMaxProportionD.substring(0, index + 3);
			}
		}
		return costMaxProportionD;
	}

	public void setCostMaxProportionD(String costMaxProportionD) {
		this.costMaxProportionD = costMaxProportionD;
	}

	public String getCostMinProportionD() {
		if (costMinProportionD != null) {
			int index = costMinProportionD.indexOf(".");
			if (index > 0 && costMinProportionD.length() >= index + 3) {
				return costMinProportionD.substring(0, index + 3);
			}
		}
		return costMinProportionD;
	}

	public void setCostMinProportionD(String costMinProportionD) {
		this.costMinProportionD = costMinProportionD;
	}

	public String getCostProportionW() {
		if (costProportionW != null) {
			int index = costProportionW.indexOf(".");
			if (index > 0 && costProportionW.length() >= index + 3) {
				return costProportionW.substring(0, index + 3);
			}
		}
		return costProportionW;
	}

	public void setCostProportionW(String costProportionW) {
		this.costProportionW = costProportionW;
	}

	public String getCostMaxProportionW() {
		if (costMaxProportionW != null) {
			int index = costMaxProportionW.indexOf(".");
			if (index > 0 && costMaxProportionW.length() >= index + 3) {
				return costMaxProportionW.substring(0, index + 3);
			}
		}
		return costMaxProportionW;
	}

	public void setCostMaxProportionW(String costMaxProportionW) {
		this.costMaxProportionW = costMaxProportionW;
	}

	public String getCostMinProportionW() {
		if (costMinProportionW != null) {
			int index = costMinProportionW.indexOf(".");
			if (index > 0 && costMinProportionW.length() >= index + 3) {
				return costMinProportionW.substring(0, index + 3);
			}
		}
		return costMinProportionW;
	}

	public void setCostMinProportionW(String costMinProportionW) {
		this.costMinProportionW = costMinProportionW;
	}

	public String getCostProportionR() {
		if (costProportionR != null) {
			int index = costProportionR.indexOf(".");
			if (index > 0 && costProportionR.length() >= index + 3) {
				return costProportionR.substring(0, index + 3);
			}
		}
		return costProportionR;
	}

	public void setCostProportionR(String costProportionR) {
		this.costProportionR = costProportionR;
	}

	public String getCostMaxProportionR() {
		if (costMaxProportionR != null) {
			int index = costMaxProportionR.indexOf(".");
			if (index > 0 && costMaxProportionR.length() >= index + 3) {
				return costMaxProportionR.substring(0, index + 3);
			}
		}
		return costMaxProportionR;
	}

	public void setCostMaxProportionR(String costMaxProportionR) {
		this.costMaxProportionR = costMaxProportionR;
	}

	public String getCostMinProportionR() {
		if (costMinProportionR != null) {
			int index = costMinProportionR.indexOf(".");
			if (index > 0 && costMinProportionR.length() >= index + 3) {
				return costMinProportionR.substring(0, index + 3);
			}
		}
		return costMinProportionR;
	}

	public void setCostMinProportionR(String costMinProportionR) {
		this.costMinProportionR = costMinProportionR;
	}

	public String getCityId() {
		return cityId;
	}

	public void setCityId(String cityId) {
		this.cityId = cityId;
	}

	public String getCityName() {
		return cityName;
	}

	public void setCityName(String cityName) {
		this.cityName = cityName;
	}

	public String getNotes() {
		return notes;
	}

	public void setNotes(String notes) {
		this.notes = notes;
	}

	public String getCouponStatus() {
		return couponStatus;
	}

	public void setCouponStatus(String couponStatus) {
		this.couponStatus = couponStatus;
	}

	public String getGoodsName() {
		return goodsName;
	}

	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}

	public String getCouponCode() {
		return couponCode;
	}

	public void setCouponCode(String couponCode) {
		this.couponCode = couponCode;
	}

	public String getFaceValue() {
		if (faceValue != null) {
			int index = faceValue.indexOf(".");
			if (index > 0 && faceValue.length() >= index + 3) {
				return faceValue.substring(0, index + 3);
			}
		}
		return faceValue;
	}

	public void setFaceValue(String faceValue) {
		this.faceValue = faceValue;
	}

	public String getRestriction() {
		return restriction;
	}

	public void setRestriction(String restriction) {
		this.restriction = restriction;
	}

	public String getCouponName() {
		return couponName;
	}

	public void setCouponName(String couponName) {
		this.couponName = couponName;
	}

	public String getMerchName() {
		return merchName;
	}

	public void setMerchName(String merchName) {
		this.merchName = merchName;
	}

	public String getMerchCode() {
		return merchCode;
	}

	public void setMerchCode(String merchCode) {
		this.merchCode = merchCode;
	}

	public String getHeadId() {
		return headId;
	}

	public void setHeadId(String headId) {
		this.headId = headId;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getPromotionCodeId() {
		return promotionCodeId;
	}

	public void setPromotionCodeId(String promotionCodeId) {
		this.promotionCodeId = promotionCodeId;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getCustomerId() {
		return customerId;
	}

	public void setCustomerId(String customerId) {
		this.customerId = customerId;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public BigDecimal getUsedAmt() {
		return usedAmt;
	}

	public void setUsedAmt(BigDecimal usedAmt) {
		this.usedAmt = usedAmt;
	}

	public String getBrandCouponStatus() {
		return brandCouponStatus;
	}

	public void setBrandCouponStatus(String brandCouponStatus) {
		this.brandCouponStatus = brandCouponStatus;
	}

	public String getDeleteFlg() {
		return deleteFlg;
	}

	public void setDeleteFlg(String deleteFlg) {
		this.deleteFlg = deleteFlg;
	}

}