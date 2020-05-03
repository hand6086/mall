package com.hand.base.goods.model;

import java.math.BigDecimal;
import java.util.Date;

import com.hand.base.basic.model.BasicModel;
import com.hand.core.util.AppConstants;

/**
 * 商品管理
 * 
 * @author wangayn
 *
 */
public class Goods extends BasicModel {

	/**
	 * 序列化
	 */
	private static final long serialVersionUID = -4285841141319718959L;
	/**
	 * 商品分类
	 */
	private String goodsType;
	/**
	 * 商品分类Id
	 */
	private String goodsTypeId;
	/**
	 * 商品大类
	 */
	private String bigGoodsType;
	/**
	 * 商品中类
	 */
	private String midGoodsType;
	/**
	 * 商品小类
	 */
	private String smallGoodsType;

	/**
	 * 商品评价
	 */
	private String goodsEvaluate;
	
	/**
	 * 用户记录当前价格：一口价
	 */
	private BigDecimal historyPrice;

	/**
	 * 店铺内是否展示
	 */
	private String storeDisplay;
	/**
	 * 原价
	 */
	private BigDecimal originalPrice;
	/**
	 * 库存
	 */
	private Integer goodsStock;
	/**
	 * 状态
	 */
	private String goodsStatus;
	/**
	 * 店铺排位
	 */
	private Integer shopOrder;
	/**
	 * 销售状态
	 */
	private String saleStatus;
	/**
	 * 审批结果
	 */
	private String approvalResult;
	/**
	 * 审批时间
	 */
	private String approvalTime;
	/**
	 * 上架时间
	 */
	private String marketTime;

	/**
	 * 审批人
	 */
	private String approvalBy;
	/**
	 * 发布人
	 */
	private String publishBy;
	/**
	 * 自动下架日期
	 */
	private String unMarketTime;

	/**
	 * 生成地址
	 */
	private String prduceAddr;

	/**
	 * 商品品牌
	 */
	private String brand;

	/**
	 * 包装方式
	 */
	private String packageMode;

	/**
	 * 包装数量
	 */
	private Integer packageCount;

	/**
	 * 时间承诺
	 */
	private String timePromise;
	/**
	 * 7天无理由退换货
	 */
	private String noReasonReturnGoods;
	/**
	 * 假一赔十
	 */
	private String compensateGoods;
	
	/**
	 * 商品69码
	 */
	private String productCode;
	
	/**
	 * 商品卖点说明
	 */
	private String goodsComments;
	
	/**
	 * 配送模板
	 */
	private String templateId;
	
	private String templateName;
	
	/**
	 * 品牌馆是否首页显示
	 */
	private String isDisplay;
	
	/**
	 * 品牌馆首页显示顺序
	 */
	private BigDecimal displayOrder;





	public String getIsDisplay() {
		return isDisplay;
	}

	public void setIsDisplay(String isDisplay) {
		this.isDisplay = isDisplay;
	}

	public BigDecimal getDisplayOrder() {
		return displayOrder;
	}

	public void setDisplayOrder(BigDecimal displayOrder) {
		this.displayOrder = displayOrder;
	}

	public String getTemplateId() {
		return templateId;
	}

	public void setTemplateId(String templateId) {
		this.templateId = templateId;
	}

	public String getGoodsComments() {
		return goodsComments;
	}

	public void setGoodsComments(String goodsComments) {
		this.goodsComments = goodsComments;
	}

	public String getPrduceAddr() {
		return prduceAddr;
	}

	public void setPrduceAddr(String prduceAddr) {
		this.prduceAddr = prduceAddr;
	}

	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	public String getPackageMode() {
		return packageMode;
	}

	public void setPackageMode(String packageMode) {
		this.packageMode = packageMode;
	}

	public Integer getPackageCount() {
		return packageCount;
	}

	public void setPackageCount(Integer packageCount) {
		this.packageCount = packageCount;
	}

	public String getTimePromise() {
		return timePromise;
	}

	public void setTimePromise(String timePromise) {
		this.timePromise = timePromise;
	}

	public String getNoReasonReturnGoods() {
		return noReasonReturnGoods;
	}

	public void setNoReasonReturnGoods(String noReasonReturnGoods) {
		this.noReasonReturnGoods = noReasonReturnGoods;
	}

	public String getCompensateGoods() {
		return compensateGoods;
	}

	public void setCompensateGoods(String compensateGoods) {
		this.compensateGoods = compensateGoods;
	}

	public String getProductCode() {
		return productCode;
	}

	public void setProductCode(String productCode) {
		this.productCode = productCode;
	}

	public String getStoreDisplay() {
		return storeDisplay;
	}

	public void setStoreDisplay(String storeDisplay) {
		this.storeDisplay = storeDisplay;
	}

	private String o2oDisplayName;
	private String o2oIntCode;
	private String o2oProdSeries;
	private String o2oFpDisplay;
	private String o2oProductIngredient;
	private String o2oStorageMethod;
	private String o2oShelfLife;
	private String o2oProdDesc;
	private String o2oCaseNumber;
	private String o2oKlNumber;
	private String name;
	private String o2oProductCode;
	private String type;
	private String o2oShareType;
	private String o2oShareTheme;
	private String o2oShareNotes;
	/**
	 * 商品URL
	 */
	private String o2oShareUrl;
	private String vodLockedFlag;
	private String vodLockedBy;
	private String vodLockedDate;
	private String prodDefTypeCode;
	private String status;
	private String prodSeriesId;
	private String cfgModelId;
	private String o2oProdId;
	private String part;
	private String unitOfMeasure;
	private String o2oProdCategory;
	private String picId;
	// 详情界面
	private String description;
	private String prePickCD;
	private String inclEligFlag;
	private String priceType;
	private String versionStatus;
	private String orderable;
	private String trackAsAssetFlag;
	private String organization;
	private String productDefTypeCode;
	private String salesProductFlag;
	private String salesServiceFlag;
	private String districtName;
	private String isRetailMerchandise;
	private String retailPrice;
	private String isGPMerchandise;
	private String groupPurchaseMinQty;
	private String groupPurchasePrice;
	private String payMode;
	private String sellingPoint;
	private String sellingPointColor;
	private String notes;
	private String districtId;
	private String prodId;
	private String productDisplayName;
	private String productIntCode;
	private String quantity;
	private String productId;
	private String parentProductId;
	private String unitId;
	
	/**
	 * 所属频道
	 */
	private String channelType; 
	
	private String linePath;

	public String getO2oDisplayName() {
		return o2oDisplayName;
	}

	public void setO2oDisplayName(String o2oDisplayName) {
		this.o2oDisplayName = o2oDisplayName;
	}

	public String getO2oIntCode() {
		return o2oIntCode;
	}

	public void setO2oIntCode(String o2oIntCode) {
		this.o2oIntCode = o2oIntCode;
	}

	public String getO2oProdSeries() {
		return o2oProdSeries;
	}

	public void setO2oProdSeries(String o2oProdSeries) {
		this.o2oProdSeries = o2oProdSeries;
	}

	public String getO2oFpDisplay() {
		return o2oFpDisplay;
	}

	public void setO2oFpDisplay(String o2oFpDisplay) {
		this.o2oFpDisplay = o2oFpDisplay;
	}

	public String getO2oProductIngredient() {
		return o2oProductIngredient;
	}

	public void setO2oProductIngredient(String o2oProductIngredient) {
		this.o2oProductIngredient = o2oProductIngredient;
	}

	public String getO2oStorageMethod() {
		return o2oStorageMethod;
	}

	public void setO2oStorageMethod(String o2oStorageMethod) {
		this.o2oStorageMethod = o2oStorageMethod;
	}

	public String getO2oShelfLife() {
		return o2oShelfLife;
	}

	public void setO2oShelfLife(String o2oShelfLife) {
		this.o2oShelfLife = o2oShelfLife;
	}

	public String getO2oProdDesc() {
		return o2oProdDesc;
	}

	public void setO2oProdDesc(String o2oProdDesc) {
		this.o2oProdDesc = o2oProdDesc;
	}

	public String getO2oCaseNumber() {
		return o2oCaseNumber;
	}

	public void setO2oCaseNumber(String o2oCaseNumber) {
		this.o2oCaseNumber = o2oCaseNumber;
	}

	public String getO2oKlNumber() {
		return o2oKlNumber;
	}

	public void setO2oKlNumber(String o2oKlNumber) {
		this.o2oKlNumber = o2oKlNumber;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getO2oProductCode() {
		return o2oProductCode;
	}

	public void setO2oProductCode(String o2oProductCode) {
		this.o2oProductCode = o2oProductCode;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getO2oShareType() {
		return o2oShareType;
	}

	public void setO2oShareType(String o2oShareType) {
		this.o2oShareType = o2oShareType;
	}

	public String getO2oShareTheme() {
		return o2oShareTheme;
	}

	public void setO2oShareTheme(String o2oShareTheme) {
		this.o2oShareTheme = o2oShareTheme;
	}

	public String getO2oShareNotes() {
		return o2oShareNotes;
	}

	public void setO2oShareNotes(String o2oShareNotes) {
		this.o2oShareNotes = o2oShareNotes;
	}

	public String getO2oShareUrl() {
		return o2oShareUrl;
	}

	public void setO2oShareUrl(String o2oShareUrl) {
		this.o2oShareUrl = o2oShareUrl;
	}

	public String getVodLockedFlag() {
		return vodLockedFlag;
	}

	public void setVodLockedFlag(String vodLockedFlag) {
		this.vodLockedFlag = vodLockedFlag;
	}

	public String getVodLockedBy() {
		return vodLockedBy;
	}

	public void setVodLockedBy(String vodLockedBy) {
		this.vodLockedBy = vodLockedBy;
	}

	public String getVodLockedDate() {
		return vodLockedDate;
	}

	public void setVodLockedDate(String vodLockedDate) {
		this.vodLockedDate = vodLockedDate;
	}

	public String getProdDefTypeCode() {
		return prodDefTypeCode;
	}

	public void setProdDefTypeCode(String prodDefTypeCode) {
		this.prodDefTypeCode = prodDefTypeCode;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getProdSeriesId() {
		return prodSeriesId;
	}

	public void setProdSeriesId(String prodSeriesId) {
		this.prodSeriesId = prodSeriesId;
	}

	public String getCfgModelId() {
		return cfgModelId;
	}

	public void setCfgModelId(String cfgModelId) {
		this.cfgModelId = cfgModelId;
	}

	public String getO2oProdId() {
		return o2oProdId;
	}

	public void setO2oProdId(String o2oProdId) {
		this.o2oProdId = o2oProdId;
	}

	public String getPart() {
		return part;
	}

	public void setPart(String part) {
		this.part = part;
	}

	public String getUnitOfMeasure() {
		return unitOfMeasure;
	}

	public void setUnitOfMeasure(String unitOfMeasure) {
		this.unitOfMeasure = unitOfMeasure;
	}

	public String getO2oProdCategory() {
		return o2oProdCategory;
	}

	public void setO2oProdCategory(String o2oProdCategory) {
		this.o2oProdCategory = o2oProdCategory;
	}

	public String getPicId() {
		return picId;
	}

	public void setPicId(String picId) {
		this.picId = picId;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getPrePickCD() {
		return prePickCD;
	}

	public void setPrePickCD(String prePickCD) {
		this.prePickCD = prePickCD;
	}

	public String getInclEligFlag() {
		return inclEligFlag;
	}

	public void setInclEligFlag(String inclEligFlag) {
		this.inclEligFlag = inclEligFlag;
	}

	public String getPriceType() {
		return priceType;
	}

	public void setPriceType(String priceType) {
		this.priceType = priceType;
	}

	public String getVersionStatus() {
		return versionStatus;
	}

	public void setVersionStatus(String versionStatus) {
		this.versionStatus = versionStatus;
	}

	public String getOrderable() {
		return orderable;
	}

	public void setOrderable(String orderable) {
		this.orderable = orderable;
	}

	public String getTrackAsAssetFlag() {
		return trackAsAssetFlag;
	}

	public void setTrackAsAssetFlag(String trackAsAssetFlag) {
		this.trackAsAssetFlag = trackAsAssetFlag;
	}

	public String getOrganization() {
		return organization;
	}

	public void setOrganization(String organization) {
		this.organization = organization;
	}

	public String getProductDefTypeCode() {
		return productDefTypeCode;
	}

	public void setProductDefTypeCode(String productDefTypeCode) {
		this.productDefTypeCode = productDefTypeCode;
	}

	public String getSalesProductFlag() {
		return salesProductFlag;
	}

	public void setSalesProductFlag(String salesProductFlag) {
		this.salesProductFlag = salesProductFlag;
	}

	public String getSalesServiceFlag() {
		return salesServiceFlag;
	}

	public void setSalesServiceFlag(String salesServiceFlag) {
		this.salesServiceFlag = salesServiceFlag;
	}

	public String getDistrictName() {
		return districtName;
	}

	public void setDistrictName(String districtName) {
		this.districtName = districtName;
	}

	public String getIsRetailMerchandise() {
		return isRetailMerchandise;
	}

	public void setIsRetailMerchandise(String isRetailMerchandise) {
		this.isRetailMerchandise = isRetailMerchandise;
	}

	public String getRetailPrice() {
		return retailPrice;
	}

	public void setRetailPrice(String retailPrice) {
		this.retailPrice = retailPrice;
	}

	public String getIsGPMerchandise() {
		return isGPMerchandise;
	}

	public void setIsGPMerchandise(String isGPMerchandise) {
		this.isGPMerchandise = isGPMerchandise;
	}

	public String getGroupPurchaseMinQty() {
		return groupPurchaseMinQty;
	}

	public void setGroupPurchaseMinQty(String groupPurchaseMinQty) {
		this.groupPurchaseMinQty = groupPurchaseMinQty;
	}

	public String getGroupPurchasePrice() {
		return groupPurchasePrice;
	}

	public void setGroupPurchasePrice(String groupPurchasePrice) {
		this.groupPurchasePrice = groupPurchasePrice;
	}

	public String getPayMode() {
		return payMode;
	}

	public void setPayMode(String payMode) {
		this.payMode = payMode;
	}

	public String getSellingPoint() {
		return sellingPoint;
	}

	public void setSellingPoint(String sellingPoint) {
		this.sellingPoint = sellingPoint;
	}

	public String getSellingPointColor() {
		return sellingPointColor;
	}

	public void setSellingPointColor(String sellingPointColor) {
		this.sellingPointColor = sellingPointColor;
	}

	public String getNotes() {
		return notes;
	}

	public void setNotes(String notes) {
		this.notes = notes;
	}

	public String getDistrictId() {
		return districtId;
	}

	public void setDistrictId(String districtId) {
		this.districtId = districtId;
	}

	public String getProductDisplayName() {
		return productDisplayName;
	}

	public void setProductDisplayName(String productDisplayName) {
		this.productDisplayName = productDisplayName;
	}

	public String getProductIntCode() {
		return productIntCode;
	}

	public void setProductIntCode(String productIntCode) {
		this.productIntCode = productIntCode;
	}

	public String getQuantity() {
		return quantity;
	}

	public void setQuantity(String quantity) {
		this.quantity = quantity;
	}

	public String getProductId() {
		return productId;
	}

	public void setProductId(String productId) {
		this.productId = productId;
	}

	public String getProdId() {
		return prodId;
	}

	public void setProdId(String prodId) {
		this.prodId = prodId;
	}

	public String getParentProductId() {
		return parentProductId;
	}

	public void setParentProductId(String parentProductId) {
		this.parentProductId = parentProductId;
	}

	public String getGoodsType() {
		return goodsType;
	}

	public void setGoodsType(String goodsType) {
		this.goodsType = goodsType;
	}

	public String getGoodsTypeId() {
		return goodsTypeId;
	}
	
	

	public String getTemplateName() {
		return templateName;
	}

	public void setTemplateName(String templateName) {
		this.templateName = templateName;
	}

	public void setGoodsTypeId(String goodsTypeId) {
		this.goodsTypeId = goodsTypeId;
	}

	public String getBigGoodsType() {
		return bigGoodsType;
	}

	public void setBigGoodsType(String bigGoodsType) {
		this.bigGoodsType = bigGoodsType;
	}

	public String getMidGoodsType() {
		return midGoodsType;
	}

	public void setMidGoodsType(String midGoodsType) {
		this.midGoodsType = midGoodsType;
	}

	public String getSmallGoodsType() {
		return smallGoodsType;
	}

	public void setSmallGoodsType(String smallGoodsType) {
		this.smallGoodsType = smallGoodsType;
	}

	public String getGoodsEvaluate() {
		return goodsEvaluate;
	}

	public void setGoodsEvaluate(String goodsEvaluate) {
		this.goodsEvaluate = goodsEvaluate;
	}

	public BigDecimal getHistoryPrice() {
		return historyPrice;
	}

	public void setHistoryPrice(BigDecimal historyPrice) {
		this.historyPrice = historyPrice;
	}

	public BigDecimal getOriginalPrice() {
		return originalPrice;
	}

	public void setOriginalPrice(BigDecimal originalPrice) {
		this.originalPrice = originalPrice;
	}

	public Integer getGoodsStock() {
		return goodsStock;
	}

	public void setGoodsStock(Integer goodsStock) {
		this.goodsStock = goodsStock;
	}

	public String getGoodsStatus() {
		return goodsStatus;
	}

	public void setGoodsStatus(String goodsStatus) {
		this.goodsStatus = goodsStatus;
	}

	public Integer getShopOrder() {
		return shopOrder;
	}

	public void setShopOrder(Integer shopOrder) {
		this.shopOrder = shopOrder;
	}

	public String getSaleStatus() {
		return saleStatus;
	}

	public void setSaleStatus(String saleStatus) {
		this.saleStatus = saleStatus;
	}

	public String getApprovalResult() {
		return approvalResult;
	}

	public void setApprovalResult(String approvalResult) {
		this.approvalResult = approvalResult;
	}

	

	public String getApprovalBy() {
		return approvalBy;
	}

	public void setApprovalBy(String approvalBy) {
		this.approvalBy = approvalBy;
	}

	public String getPublishBy() {
		return publishBy;
	}

	public void setPublishBy(String publishBy) {
		this.publishBy = publishBy;
	}

	public String getApprovalTime() {
		return approvalTime;
	}

	public void setApprovalTime(String approvalTime) {
		this.approvalTime = approvalTime;
	}

	public String getMarketTime() {
		return marketTime;
	}

	public void setMarketTime(String marketTime) {
		this.marketTime = marketTime;
	}

	public String getUnMarketTime() {
		return unMarketTime;
	}

	public void setUnMarketTime(String unMarketTime) {
		this.unMarketTime = unMarketTime;
	}

	public String getUnitId() {
		return unitId;
	}

	public void setUnitId(String unitId) {
		this.unitId = unitId;
	}

	public String getChannelType() {
		return channelType;
	}

	public void setChannelType(String channelType) {
		this.channelType = channelType;
	}

	public String getLinePath() {
		if (linePath != null && !"".equals(linePath)) {
			return AppConstants.portalSharePicHttpDir+linePath;
		} else {
			return linePath;
		}
	}

	public void setLinePath(String linePath) {
		this.linePath = linePath;
	}

}
