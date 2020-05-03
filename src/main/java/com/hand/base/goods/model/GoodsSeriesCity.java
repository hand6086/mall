package com.hand.base.goods.model;

import com.hand.base.basic.model.BasicModel;

/**
 * 商品系列
 * @author wangayn
 *
 */
public class GoodsSeriesCity extends BasicModel{
	
	private String cityNotes;			
	private String cityName;			
	private String cityId;
	private String code;
	private String name;
	private String fpDisplay;
	private String displayOrder;
	private String status;
	private String notes;
	private String o2oSeriesId;
	private String parentName;
	
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
	public String getCityId() {
		return cityId;
	}
	public void setCityId(String cityId) {
		this.cityId = cityId;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getFpDisplay() {
		return fpDisplay;
	}
	public void setFpDisplay(String fpDisplay) {
		this.fpDisplay = fpDisplay;
	}
	public String getDisplayOrder() {
		return displayOrder;
	}
	public void setDisplayOrder(String displayOrder) {
		this.displayOrder = displayOrder;
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
	public String getO2oSeriesId() {
		return o2oSeriesId;
	}
	public void setO2oSeriesId(String o2oSeriesId) {
		this.o2oSeriesId = o2oSeriesId;
	}
	public String getParentName() {
		return parentName;
	}
	public void setParentName(String parentName) {
		this.parentName = parentName;
	}
	
}
