package com.hand.base.goods.model;

import java.math.BigDecimal;

import com.hand.base.basic.model.BasicModel;
import com.hand.core.util.AppConstants;

/**
 * 商品价格
 * 
 * @author wangayn
 *
 */
public class GoodsPrice extends BasicModel {

	/**
	 * 序列号
	 */
	private static final long serialVersionUID = -4500556907689099388L;

	/**
	 * 是否马上喝商品
	 */
	private String isDrinkNow;

	/**
	 * 是否送餐厅商品
	 */
	private String isSendRestaurant;

	/**
	 * 是否爱新品商品
	 */
	private String isNewProduct;

	/**
	 * 配送费模板Id
	 */
	private String freightId;

	/**
	 * 配送费模板名称
	 */
	private String freightName;

	/**
	 * 有效开始时间
	 */
	private String startTime;

	/**
	 * 有效结束时间
	 */
	private String endTime;

	/**
	 * 爱新品轮播图片URL
	 */
	private String prodUrl;

	/**
	 * 是否显示
	 */
	private String isDisplay;
	/**
	 * APP首页展示图片
	 */
	private String appPic;
	
	/**
	 * 一级页面轮播图片
	 */
	private String onePic;
	
	/**
	 * 商品海报图片
	 */
	private String[] picArray;
	/**
	 * 删除的商品海报图片
	 */
	private String[] delPicArray;
	
	private String prodDisplayName;
	private String prodIntCode;
	private String prodId;
	private String isRetailMerchandise;
	private String retailPrice;
	private String isGpMerchandise;
	private String groupPurchaseMinQty;
	private String groupPurchasePrice;
	private String payMode;
	private String displaySequence;
	private String sellingPoint;
	private String sellingPointColor;
	private String status;
	private String notes;
	private String partialMerchantSellFlag;
	private String districtId;
	private String prodPriceId;
	private String merchantCode;
	private String merchantName;
	private String o2oForcedStore;
	private String o2oDistrict;
	private String merchantId;
	private String o2oDisplayName;
	private String o2oIntCode;
	private String name;
	private String csn;
	private String o2oStoreType;
	private String o2oAccountStatus;
	private String o2oProvince;
	private String o2oCity;
	private String o2oContact;
	private String o2oContactPhone;

	private String districtName;
	
	private String type;
	private String appPicUrl;
	private String onePicUrl;
	
	private String path;
	private String picId;
	private String prodPricUrl;
	
	private Double dnDisplaySequence;
	private Double srDisplaySequence;
	private Double npDisplaySequence;

	/**
	 * 是否套装商品 标志
	 */
	private String suitProductFlg;
	
	/**
	 * 商品零售价
	 */
	private String totalPrice;
	
	/**
	 * 品牌馆商品市场价
	 */
	private BigDecimal originalPrice;
	
	/**
	 * 品牌馆商品一口价
	 */
	private BigDecimal historyPrice;

	public BigDecimal getOriginalPrice() {
		return originalPrice;
	}

	public void setOriginalPrice(BigDecimal originalPrice) {
		this.originalPrice = originalPrice;
	}

	public String getDistrictName() {
		return districtName;
	}

	public void setDistrictName(String districtName) {
		this.districtName = districtName;
	}

	public String getIsDrinkNow() {
		return isDrinkNow;
	}

	public void setIsDrinkNow(String isDrinkNow) {
		this.isDrinkNow = isDrinkNow;
	}

	public String getIsSendRestaurant() {
		return isSendRestaurant;
	}

	public void setIsSendRestaurant(String isSendRestaurant) {
		this.isSendRestaurant = isSendRestaurant;
	}

	public String getIsNewProduct() {
		return isNewProduct;
	}

	public void setIsNewProduct(String isNewProduct) {
		this.isNewProduct = isNewProduct;
	}

	public String getFreightId() {
		return freightId;
	}

	public void setFreightId(String freightId) {
		this.freightId = freightId;
	}

	public String getFreightName() {
		return freightName;
	}

	public void setFreightName(String freightName) {
		this.freightName = freightName;
	}

	public String getProdDisplayName() {
		return prodDisplayName;
	}

	public void setProdDisplayName(String prodDisplayName) {
		this.prodDisplayName = prodDisplayName;
	}

	public String getProdIntCode() {
		return prodIntCode;
	}

	public void setProdIntCode(String prodIntCode) {
		this.prodIntCode = prodIntCode;
	}

	public String getProdId() {
		return prodId;
	}

	public void setProdId(String prodId) {
		this.prodId = prodId;
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

	public String getIsGpMerchandise() {
		return isGpMerchandise;
	}

	public void setIsGpMerchandise(String isGpMerchandise) {
		this.isGpMerchandise = isGpMerchandise;
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

	public String getDisplaySequence() {
		return displaySequence;
	}

	public void setDisplaySequence(String displaySequence) {
		this.displaySequence = displaySequence;
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

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getNotes() {
		return notes;
	}

	public void setNotes(String notes) {
		this.notes = notes;
	}

	public String getPartialMerchantSellFlag() {
		return partialMerchantSellFlag;
	}

	public void setPartialMerchantSellFlag(String partialMerchantSellFlag) {
		this.partialMerchantSellFlag = partialMerchantSellFlag;
	}

	public String getDistrictId() {
		return districtId;
	}

	public void setDistrictId(String districtId) {
		this.districtId = districtId;
	}

	public String getProdPriceId() {
		return prodPriceId;
	}

	public void setProdPriceId(String prodPriceId) {
		this.prodPriceId = prodPriceId;
	}

	public String getMerchantCode() {
		return merchantCode;
	}

	public void setMerchantCode(String merchantCode) {
		this.merchantCode = merchantCode;
	}

	public String getMerchantName() {
		return merchantName;
	}

	public void setMerchantName(String merchantName) {
		this.merchantName = merchantName;
	}

	public String getO2oForcedStore() {
		return o2oForcedStore;
	}

	public void setO2oForcedStore(String o2oForcedStore) {
		this.o2oForcedStore = o2oForcedStore;
	}

	public String getO2oDistrict() {
		return o2oDistrict;
	}

	public void setO2oDistrict(String o2oDistrict) {
		this.o2oDistrict = o2oDistrict;
	}

	public String getMerchantId() {
		return merchantId;
	}

	public void setMerchantId(String merchantId) {
		this.merchantId = merchantId;
	}

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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCsn() {
		return csn;
	}

	public void setCsn(String csn) {
		this.csn = csn;
	}

	public String getO2oStoreType() {
		return o2oStoreType;
	}

	public void setO2oStoreType(String o2oStoreType) {
		this.o2oStoreType = o2oStoreType;
	}

	public String getO2oAccountStatus() {
		return o2oAccountStatus;
	}

	public void setO2oAccountStatus(String o2oAccountStatus) {
		this.o2oAccountStatus = o2oAccountStatus;
	}

	public String getO2oProvince() {
		return o2oProvince;
	}

	public void setO2oProvince(String o2oProvince) {
		this.o2oProvince = o2oProvince;
	}

	public String getO2oCity() {
		return o2oCity;
	}

	public void setO2oCity(String o2oCity) {
		this.o2oCity = o2oCity;
	}

	public String getO2oContact() {
		return o2oContact;
	}

	public void setO2oContact(String o2oContact) {
		this.o2oContact = o2oContact;
	}

	public String getO2oContactPhone() {
		return o2oContactPhone;
	}

	public void setO2oContactPhone(String o2oContactPhone) {
		this.o2oContactPhone = o2oContactPhone;
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

	public String getProdUrl() {
		return prodUrl;
	}

	public void setProdUrl(String prodUrl) {
		this.prodUrl = prodUrl;
	}

	public String getIsDisplay() {
		return isDisplay;
	}

	public void setIsDisplay(String isDisplay) {
		this.isDisplay = isDisplay;
	}

	public String getSuitProductFlg() {
		return suitProductFlg;
	}

	public void setSuitProductFlg(String suitProductFlg) {
		this.suitProductFlg = suitProductFlg;
	}

	public String getAppPic() {
		return appPic;
	}

	public void setAppPic(String appPic) {
		this.appPic = appPic;
	}

	public String getOnePic() {
		return onePic;
	}

	public void setOnePic(String onePic) {
		this.onePic = onePic;
	}

	public String[] getPicArray() {
		return picArray;
	}

	public void setPicArray(String[] picArray) {
		this.picArray = picArray;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getAppPicUrl() {
		if (appPicUrl != null && !"".equals(appPicUrl)) {
			return AppConstants.portalSharePicHttpDir+appPicUrl;
		} else {
			return appPicUrl;
		}
	}

	public void setAppPicUrl(String appPicUrl) {
		this.appPicUrl = appPicUrl;
	}

	public String getOnePicUrl() {
		if (onePicUrl != null && !"".equals(onePicUrl)) {
			return AppConstants.portalSharePicHttpDir+onePicUrl;
		} else {
			return onePicUrl;
		}
	}

	public void setOnePicUrl(String onePicUrl) {
		this.onePicUrl = onePicUrl;
	}

	public String getPath() {
		if (path != null && !"".equals(path)) {
			return AppConstants.portalSharePicHttpDir+path;
		} else {
			return path;
		}
	}

	public void setPath(String path) {
		this.path = path;
	}

	public String[] getDelPicArray() {
		return delPicArray;
	}

	public void setDelPicArray(String[] delPicArray) {
		this.delPicArray = delPicArray;
	}

	public String getPicId() {
		return picId;
	}

	public void setPicId(String picId) {
		this.picId = picId;
	}

	public String getProdPricUrl() {
		return prodPricUrl;
	}

	public void setProdPricUrl(String prodPricUrl) {
		this.prodPricUrl = prodPricUrl;
	}

	public Double getDnDisplaySequence() {
		return dnDisplaySequence;
	}

	public void setDnDisplaySequence(Double dnDisplaySequence) {
		this.dnDisplaySequence = dnDisplaySequence;
	}

	public Double getSrDisplaySequence() {
		return srDisplaySequence;
	}

	public void setSrDisplaySequence(Double srDisplaySequence) {
		this.srDisplaySequence = srDisplaySequence;
	}

	public Double getNpDisplaySequence() {
		return npDisplaySequence;
	}

	public void setNpDisplaySequence(Double npDisplaySequence) {
		this.npDisplaySequence = npDisplaySequence;
	}

	public String getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(String totalPrice) {
		this.totalPrice = totalPrice;
	}

	public BigDecimal getHistoryPrice() {
		return historyPrice;
	}

	public void setHistoryPrice(BigDecimal historyPrice) {
		this.historyPrice = historyPrice;
	}

}
