package com.hand.base.promotion.model;

import java.math.BigDecimal;

import com.hand.base.basic.model.BasicModel;
import com.hand.core.util.AppConstants;

public class Promotion extends BasicModel {
	/**
	 * 
	 */
	private static final long serialVersionUID = -4959767790569825950L;
	private String campaignLineId;
	private String customerName;
	private String customerCode;
	private String customerPhone;
	private String buyMerchName;
	private String buyMerchId;
	private String freeMerchId;
	private String costMaxProportionD; /* 经销商承担费用上限 */
	private String cityId; /* 城市id */
	private String costProportionR; /* 终端承担费用比例 */
	private String endTime; /* 有效结束时间 */
	private String costMinProportionR; /* 终端承担费用下限 */
	private String headId; /* 关联字段 */
	private String costMaxProportionW; /* 二批商承担费用上限 */
	private String costMinProportionD; /* 经销商承担费用下限 */
	private String successRate; /* 秒杀成功率 */
	private BigDecimal totalQty; /* 限购总量/赠送总量 */
	private String activityName; /* 活动名称 */
	private String merchName; /* 满囎商品 */
	private String payMode; /* 支付方式 */
	private String activityCode; /* 活动编码 */
	private String onCouponName; /* 优惠券名称 */
	private String couponId; /* 优惠券Id*/
	private String merchCode; /* 商品编码 */
	private String costMinProportionW; /* 二批商承担费用下限 */
	private String activityNotes; /* 说明 */
	private String startTime; /* 有效开始时间 */
	private String costMaxProportionR; /* 终端承担费用上限 */
	private String status; /* 有效,值列表类型: TB_O2O_STATUS */
	private String costProportionD; /* 经销商承担费用比例 */
	private String costProportionW; /* 二批商承担费用比例 */
	private String type; /* 类型,值列表类型: TB_O2O_CAMPAIGN_TYPE */
	private String t_ATTR_12; /* 秒杀成功率 */
	private String noCouponUse; /* 是否可用优惠券,值列表类型: TB_O2O_COUPON_USE */
	private BigDecimal lmtAmt; /* 单人限赠数量 */
	private BigDecimal promotionPrice; /* 活动价 */
	private BigDecimal buyAmt; /* 购买数量 */
	private BigDecimal freeAmt; /* 赠送数量 */
	private String freeMerchName; /* 增送商品名称 */
	private String purchasedQty; /* 已售数量/已赠数量 */
	private BigDecimal groupsNumber; /* 拼团人数 */
	private BigDecimal totalPrice; /* 原价合计 */
	private String merchStartTime; /* 商品开始时间 */
	private String merchEndTime; /* 商品结束时间 */
	private String createdName;/* 创建人 */
	private String approvalFlg;/* 自动审批 */
	private String path;/* 图片路径 */
	private BigDecimal originalPrice;/* 品牌馆市场价 */
	private String brandDiscountType;/* 品牌馆优惠类型 */
	private String brandStatus;/* 单品优惠活动状态 */
	private BigDecimal brandDiscount;/* 品牌馆折扣 */
	private BigDecimal minOrdAmount;/* 订单满金额 */
	private BigDecimal deducedCash;/* 满减金额 */
	private String[] buyMerchIds; /*品牌馆组合搭配商品数组*/
	private BigDecimal[] buyAmts; /*品牌馆组合商品搭配数量数组*/
	private BigDecimal[] pmoPrices; /*品牌馆组合商品平摊价组合*/
	private BigDecimal displaySeq; /*品牌馆组合商品顺序*/
	private BigDecimal releaseAmt; /*满赠赠送商品数量*/
	private String isHomeProd; /*是否主商品*/
	private BigDecimal historyPrice; /*一口价*/
	private String comments; /*套餐商品搭配详情*/
	private String lmtBInfo;/*限购信息*/
	private String  ifCashDeduction;  /*是否同享满减*/
	/**
	 * 页面是否删除标识
	 */
	private String deleteFlg;
	
	public BigDecimal getBrandDiscount() {
		return brandDiscount;
	}

	public void setBrandDiscount(BigDecimal brandDiscount) {
		this.brandDiscount = brandDiscount;
	}

	public String getBrandStatus() {
		return brandStatus;
	}

	public void setBrandStatus(String brandStatus) {
		this.brandStatus = brandStatus;
	}

	public String getMerchStartTime() {
		return merchStartTime;
	}

	public void setMerchStartTime(String merchStartTime) {
		this.merchStartTime = merchStartTime;
	}

	public String getMerchEndTime() {
		return merchEndTime;
	}

	public void setMerchEndTime(String merchEndTime) {
		this.merchEndTime = merchEndTime;
	}

	public String getCampaignLineId() {
		return campaignLineId;
	}

	public void setCampaignLineId(String campaignLineId) {
		this.campaignLineId = campaignLineId;
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

	public String getCustomerPhone() {
		return customerPhone;
	}

	public void setCustomerPhone(String customerPhone) {
		this.customerPhone = customerPhone;
	}

	/**
	 * 行关联ID
	 */
	private String schemaId;

	/**
	 * 审批状态
	 */
	private String approvalStatus;

	/**
	 * 审批界面 常规界面标志
	 */
	private String isApproved;

	/**
	 * 审批意见
	 */
	private String approvalSuggest;

	/**
	 * 城市 说明
	 */
	private String cityNotes;

	/**
	 * 大区 城市
	 */
	private String cityName;

	/**
	 * 大区 省
	 */
	private String name;

	/**
	 * 促销方案 促销类型 的值列表 独立源代码
	 */
	private String val;

	public String getCostMaxProportionD() {
		return costMaxProportionD;
	}

	public void setCostMaxProportionD(String costMaxProportionD) {
		this.costMaxProportionD = costMaxProportionD;
	}

	public String getCityId() {
		return cityId;
	}

	public void setCityId(String cityId) {
		this.cityId = cityId;
	}

	public String getCostProportionR() {
		return costProportionR;
	}

	public void setCostProportionR(String costProportionR) {
		this.costProportionR = costProportionR;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public String getCostMinProportionR() {
		return costMinProportionR;
	}

	public void setCostMinProportionR(String costMinProportionR) {
		this.costMinProportionR = costMinProportionR;
	}

	public String getHeadId() {
		return headId;
	}

	public void setHeadId(String headId) {
		this.headId = headId;
	}

	public String getCostMaxProportionW() {
		return costMaxProportionW;
	}

	public void setCostMaxProportionW(String costMaxProportionW) {
		this.costMaxProportionW = costMaxProportionW;
	}

	public String getCostMinProportionD() {
		return costMinProportionD;
	}

	public void setCostMinProportionD(String costMinProportionD) {
		this.costMinProportionD = costMinProportionD;
	}

	public BigDecimal getTotalQty() {
		return totalQty;
	}

	public void setTotalQty(BigDecimal totalQty) {
		this.totalQty = totalQty;
	}

	public String getActivityName() {
		return activityName;
	}

	public void setActivityName(String activityName) {
		this.activityName = activityName;
	}

	public String getMerchName() {
		return merchName;
	}

	public void setMerchName(String merchName) {
		this.merchName = merchName;
	}

	public String getActivityCode() {
		return activityCode;
	}

	public void setActivityCode(String activityCode) {
		this.activityCode = activityCode;
	}

	public String getOnCouponName() {
		return onCouponName;
	}

	public void setOnCouponName(String onCouponName) {
		this.onCouponName = onCouponName;
	}

	public String getCouponId() {
		return couponId;
	}

	public void setCouponId(String couponId) {
		this.couponId = couponId;
	}

	public String getMerchCode() {
		return merchCode;
	}

	public void setMerchCode(String merchCode) {
		this.merchCode = merchCode;
	}

	public String getCostMinProportionW() {
		return costMinProportionW;
	}

	public void setCostMinProportionW(String costMinProportionW) {
		this.costMinProportionW = costMinProportionW;
	}

	public String getActivityNotes() {
		return activityNotes;
	}

	public void setActivityNotes(String activityNotes) {
		this.activityNotes = activityNotes;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getCostMaxProportionR() {
		return costMaxProportionR;
	}

	public void setCostMaxProportionR(String costMaxProportionR) {
		this.costMaxProportionR = costMaxProportionR;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getCostProportionD() {
		return costProportionD;
	}

	public void setCostProportionD(String costProportionD) {
		this.costProportionD = costProportionD;
	}

	public String getCostProportionW() {
		return costProportionW;
	}

	public void setCostProportionW(String costProportionW) {
		this.costProportionW = costProportionW;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getT_ATTR_12() {
		return t_ATTR_12;
	}

	public void setT_ATTR_12(String t_ATTR_12) {
		this.t_ATTR_12 = t_ATTR_12;
	}

	public String getNoCouponUse() {
		return noCouponUse;
	}

	public void setNoCouponUse(String noCouponUse) {
		this.noCouponUse = noCouponUse;
	}

	public BigDecimal getLmtAmt() {
		return lmtAmt;
	}

	public void setLmtAmt(BigDecimal lmtAmt) {
		this.lmtAmt = lmtAmt;
	}

	public BigDecimal getPromotionPrice() {
		return promotionPrice;
	}

	public void setPromotionPrice(BigDecimal promotionPrice) {
		this.promotionPrice = promotionPrice;
	}

	public BigDecimal getBuyAmt() {
		return buyAmt;
	}

	public void setBuyAmt(BigDecimal buyAmt) {
		this.buyAmt = buyAmt;
	}

	public BigDecimal getFreeAmt() {
		return freeAmt;
	}

	public void setFreeAmt(BigDecimal freeAmt) {
		this.freeAmt = freeAmt;
	}

	public String getFreeMerchName() {
		return freeMerchName;
	}

	public void setFreeMerchName(String freeMerchName) {
		this.freeMerchName = freeMerchName;
	}

	public String getPurchasedQty() {
		return purchasedQty;
	}

	public void setPurchasedQty(String purchasedQty) {
		this.purchasedQty = purchasedQty;
	}

	public String getBuyMerchName() {
		return buyMerchName;
	}

	public void setBuyMerchName(String buyMerchName) {
		this.buyMerchName = buyMerchName;
	}

	public String getSuccessRate() {
		return successRate;
	}

	public void setSuccessRate(String successRate) {
		this.successRate = successRate;
	}

	public String getPayMode() {
		return payMode;
	}

	public void setPayMode(String payMode) {
		this.payMode = payMode;
	}

	public String getBuyMerchId() {
		return buyMerchId;
	}

	public void setBuyMerchId(String buyMerchId) {
		this.buyMerchId = buyMerchId;
	}

	public String getFreeMerchId() {
		return freeMerchId;
	}

	public void setFreeMerchId(String freeMerchId) {
		this.freeMerchId = freeMerchId;
	}

	public BigDecimal getGroupsNumber() {
		return groupsNumber;
	}

	public void setGroupsNumber(BigDecimal groupsNumber) {
		this.groupsNumber = groupsNumber;
	}

	public BigDecimal getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(BigDecimal totalPrice) {
		this.totalPrice = totalPrice;
	}

	public String getSchemaId() {
		return schemaId;
	}

	public void setSchemaId(String schemaId) {
		this.schemaId = schemaId;
	}

	public String getApprovalStatus() {
		return approvalStatus;
	}

	public void setApprovalStatus(String approvalStatus) {
		this.approvalStatus = approvalStatus;
	}

	public String getIsApproved() {
		return isApproved;
	}

	public void setIsApproved(String isApproved) {
		this.isApproved = isApproved;
	}

	public String getApprovalSuggest() {
		return approvalSuggest;
	}

	public void setApprovalSuggest(String approvalSuggest) {
		this.approvalSuggest = approvalSuggest;
	}

	public String getCityNotes() {
		return cityNotes;
	}

	public void setCityNotes(String cityNotes) {
		this.cityNotes = cityNotes;
	}

	public String getCityName() {
		return cityName;
	}

	public void setCityName(String cityName) {
		this.cityName = cityName;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getVal() {
		return val;
	}

	public void setVal(String val) {
		this.val = val;
	}

	public String getCreatedName() {
		return createdName;
	}

	public void setCreatedName(String createdName) {
		this.createdName = createdName;
	}

	public String getApprovalFlg() {
		return approvalFlg;
	}

	public void setApprovalFlg(String approvalFlg) {
		this.approvalFlg = approvalFlg;
	}

	public String getPath() {
		if (path != null && !"".equals(path)) {
			return AppConstants.portalSharePicHttpDir + path;
		}
		return AppConstants.portalStaticUrl + "/static/images/404.jpg";
	}

	public void setPath(String path) {
		this.path = path;
	}

	public BigDecimal getOriginalPrice() {
		return originalPrice;
	}

	public void setOriginalPrice(BigDecimal originalPrice) {
		this.originalPrice = originalPrice;
	}

	public String getBrandDiscountType() {
		return brandDiscountType;
	}

	public void setBrandDiscountType(String brandDiscountType) {
		this.brandDiscountType = brandDiscountType;
	}

	public BigDecimal getMinOrdAmount() {
		return minOrdAmount;
	}

	public void setMinOrdAmount(BigDecimal minOrdAmount) {
		this.minOrdAmount = minOrdAmount;
	}

	public BigDecimal getDeducedCash() {
		return deducedCash;
	}

	public void setDeducedCash(BigDecimal deducedCash) {
		this.deducedCash = deducedCash;
	}

	public String[] getBuyMerchIds() {
		return buyMerchIds;
	}

	public void setBuyMerchIds(String[] buyMerchIds) {
		this.buyMerchIds = buyMerchIds;
	}

	public BigDecimal[] getBuyAmts() {
		return buyAmts;
	}

	public void setBuyAmts(BigDecimal[] buyAmts) {
		this.buyAmts = buyAmts;
	}

	public BigDecimal[] getPmoPrices() {
		return pmoPrices;
	}

	public void setPmoPrices(BigDecimal[] pmoPrices) {
		this.pmoPrices = pmoPrices;
	}

	public BigDecimal getDisplaySeq() {
		return displaySeq;
	}

	public void setDisplaySeq(BigDecimal displaySeq) {
		this.displaySeq = displaySeq;
	}

	public BigDecimal getReleaseAmt() {
		return releaseAmt;
	}

	public void setReleaseAmt(BigDecimal releaseAmt) {
		this.releaseAmt = releaseAmt;
	}

	public String getIsHomeProd() {
		return isHomeProd;
	}

	public void setIsHomeProd(String isHomeProd) {
		this.isHomeProd = isHomeProd;
	}

	public BigDecimal getHistoryPrice() {
		return historyPrice;
	}

	public void setHistoryPrice(BigDecimal historyPrice) {
		this.historyPrice = historyPrice;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}

	public String getDeleteFlg() {
		return deleteFlg;
	}

	public void setDeleteFlg(String deleteFlg) {
		this.deleteFlg = deleteFlg;
	}

	public String getLmtBInfo() {
		return lmtBInfo;
	}

	public void setLmtBInfo(String lmtBInfo) {
		this.lmtBInfo = lmtBInfo;
	}

	public String getifCashDeduction() {
		return ifCashDeduction;
	}

	public void setifCashDeduction(String ifCashDeduction) {
		this.ifCashDeduction = ifCashDeduction;
	}

}