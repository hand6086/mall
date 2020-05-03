package com.hand.base.workbench.model;

import com.hand.base.basic.model.BasicModel;
import com.hand.core.util.AppConstants;

/**
 * 
 * @author wangayn
 *
 */
public class Campaign extends BasicModel{
	
	/**
	 * 承接页头表
	 */
	private static final long serialVersionUID = -8137036347261683997L;
	private String name;
	private String code;
	private String status;
	private String shareType;
	private String shareTheme;
	private String url;
	private String shareNotes;
	private String type;
	private String cityName;
	private String cityId;
	private String charePicId;
	private String lineType;
	private String prodName;
	private String prodCode;
	private String couponName;
	private String couponCode;
	private String displaySeq;
	private String camId;
	private String camType;
	private String couponId;
	private String isDisplay;
	private String picId;
	private String prodId;
	private String amtPerConsumer;
	private String drawType;
	private String faceValue;
	private String restriction;
	
	private String  city;
	private String  endTime;
	private String  notes;
	private String  startTime;
	
	private String shareUrl;
	private String source;
	private String classifyId;
	private String classifyName;
	
	private String picUrl;
	private String promotionId;
	private String promotionName;
	private String promotionStartTime;
	private String promotionEndTime;
	private String promotionCityId;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getShareType() {
		return shareType;
	}
	public void setShareType(String shareType) {
		this.shareType = shareType;
	}
	public String getShareTheme() {
		return shareTheme;
	}
	public void setShareTheme(String shareTheme) {
		this.shareTheme = shareTheme;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getShareNotes() {
		return shareNotes;
	}
	public void setShareNotes(String shareNotes) {
		this.shareNotes = shareNotes;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getCityName() {
		return cityName;
	}
	public void setCityName(String cityName) {
		this.cityName = cityName;
	}
	public String getCityId() {
		return cityId;
	}
	public void setCityId(String cityId) {
		this.cityId = cityId;
	}
	public String getCharePicId() {
		return charePicId;
	}
	public void setCharePicId(String charePicId) {
		this.charePicId = charePicId;
	}
	public String getLineType() {
		return lineType;
	}
	public void setLineType(String lineType) {
		this.lineType = lineType;
	}
	public String getProdName() {
		return prodName;
	}
	public void setProdName(String prodName) {
		this.prodName = prodName;
	}
	public String getProdCode() {
		return prodCode;
	}
	public void setProdCode(String prodCode) {
		this.prodCode = prodCode;
	}
	public String getCouponName() {
		return couponName;
	}
	public void setCouponName(String couponName) {
		this.couponName = couponName;
	}
	public String getCouponCode() {
		return couponCode;
	}
	public void setCouponCode(String couponCode) {
		this.couponCode = couponCode;
	}
	public String getDisplaySeq() {
		return displaySeq;
	}
	public void setDisplaySeq(String displaySeq) {
		this.displaySeq = displaySeq;
	}
	public String getCamId() {
		return camId;
	}
	public void setCamId(String camId) {
		this.camId = camId;
	}
	public String getCamType() {
		return camType;
	}
	public void setCamType(String camType) {
		this.camType = camType;
	}
	public String getCouponId() {
		return couponId;
	}
	public void setCouponId(String couponId) {
		this.couponId = couponId;
	}
	public String getIsDisplay() {
		return isDisplay;
	}
	public void setIsDisplay(String isDisplay) {
		this.isDisplay = isDisplay;
	}
	public String getPicId() {
		return picId;
	}
	public void setPicId(String picId) {
		this.picId = picId;
	}
	public String getProdId() {
		return prodId;
	}
	public void setProdId(String prodId) {
		this.prodId = prodId;
	}
	public String getAmtPerConsumer() {
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
	public String getFaceValue() {
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
	public String getShareUrl() {
		if (shareUrl != null && !"".equals(shareUrl)) {
			return AppConstants.portalSharePicHttpDir+shareUrl;
		} else {
			return shareUrl;
		}
	}
	public void setShareUrl(String shareUrl) {
		this.shareUrl = shareUrl;
	}
	public String getSource() {
		return source;
	}
	public void setSource(String source) {
		this.source = source;
	}
	public String getClassifyId() {
		return classifyId;
	}
	public void setClassifyId(String classifyId) {
		this.classifyId = classifyId;
	}
	public String getClassifyName() {
		return classifyName;
	}
	public void setClassifyName(String classifyName) {
		this.classifyName = classifyName;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public String getNotes() {
		return notes;
	}
	public void setNotes(String notes) {
		this.notes = notes;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getPicUrl() {
		if (picUrl != null && !"".equals(picUrl)) {
			return AppConstants.portalSharePicHttpDir+picUrl;
		} else {
			return picUrl;
		}
	}
	public void setPicUrl(String picUrl) {
		this.picUrl = picUrl;
	}
	public String getPromotionId() {
		return promotionId;
	}
	public void setPromotionId(String promotionId) {
		this.promotionId = promotionId;
	}
	public String getPromotionName() {
		return promotionName;
	}
	public void setPromotionName(String promotionName) {
		this.promotionName = promotionName;
	}
	public String getPromotionStartTime() {
		return promotionStartTime;
	}
	public void setPromotionStartTime(String promotionStartTime) {
		this.promotionStartTime = promotionStartTime;
	}
	public String getPromotionEndTime() {
		return promotionEndTime;
	}
	public void setPromotionEndTime(String promotionEndTime) {
		this.promotionEndTime = promotionEndTime;
	}
	public String getPromotionCityId() {
		return promotionCityId;
	}
	public void setPromotionCityId(String promotionCityId) {
		this.promotionCityId = promotionCityId;
	}
	
}
