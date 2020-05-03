package com.hand.base.workbench.model;

import com.hand.base.basic.model.BasicModel;
import com.hand.core.util.AppConstants;

/**
 * 商品系列
 * @author wangayn
 *
 */
public class CamPic extends BasicModel{
	
	private String lineType;		//类型
	private String prodName;		//商品名称
	private String prodCode;		//商品编码
	private String promotionName;		//秒杀名称
	private String promotionCity;       //秒杀城市
	private String promotionStartTime;	//秒杀开始时间
	private String promotionEndTime;	//秒杀结束时间
	private String displaySeq;		//显示顺序
	private String status;			//状态
	private String prodId;
	private String promotionId;		
	private String promotionCityId;
	private String camId;
	private String cityId;
	private String city;
	private String endTime;
	private String name;
	private String notes;
	private String startTime;
	private String picId;
	private String picUrl;
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
	public String getPromotionName() {
		return promotionName;
	}
	public void setPromotionName(String promotionName) {
		this.promotionName = promotionName;
	}
	public String getPromotionCity() {
		return promotionCity;
	}
	public void setPromotionCity(String promotionCity) {
		this.promotionCity = promotionCity;
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
	public String getDisplaySeq() {
		return displaySeq;
	}
	public void setDisplaySeq(String displaySeq) {
		this.displaySeq = displaySeq;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getProdId() {
		return prodId;
	}
	public void setProdId(String prodId) {
		this.prodId = prodId;
	}
	public String getPromotionId() {
		return promotionId;
	}
	public void setPromotionId(String promotionId) {
		this.promotionId = promotionId;
	}
	public String getPromotionCityId() {
		return promotionCityId;
	}
	public void setPromotionCityId(String promotionCityId) {
		this.promotionCityId = promotionCityId;
	}
	public String getCamId() {
		return camId;
	}
	public void setCamId(String camId) {
		this.camId = camId;
	}
	public String getCityId() {
		return cityId;
	}
	public void setCityId(String cityId) {
		this.cityId = cityId;
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
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
	public String getPicId() {
		return picId;
	}
	public void setPicId(String picId) {
		this.picId = picId;
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
}
