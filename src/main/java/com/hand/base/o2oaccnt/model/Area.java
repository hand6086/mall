package com.hand.base.o2oaccnt.model;

import com.hand.base.basic.model.BasicModel;

public class Area extends BasicModel{
	private String  areaName ;/*区域名称*/
	private String 	areaType ;/*区域类型*/
	private String 	areaCode ;/*区域编码*/
	private String  isO2OArea ;/*是否O2O平台区域*/
	private String 	parentId; /*父区域id*/
	private String 	parentAreaName; /*父区域名称*/
	private String 	parentAreaType ;/*父区域类型*/
	private String  attr04; /*关联真实名字的字段*/
	private String  actualCity;	/*真实名字*/
	private String  actualCityType; /*真实城市区域类型*/
	private String 	orgOnName; /*对应组织*/
	private String  isO2ODistrict ;/*是否地配区域*/
	private String areaImgId ; /*图片id*/
	
	
	
	
	public String getAreaImgId() {
		return areaImgId;
	}
	public void setAreaImgId(String areaImgId) {
		this.areaImgId = areaImgId;
	}
	public String getAttr04() {
		return attr04;
	}
	public void setAttr04(String attr04) {
		this.attr04 = attr04;
	}
	public String getParentId() {
		return parentId;
	}
	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	public String getAreaName() {
		return areaName;
	}
	public void setAreaName(String areaName) {
		this.areaName = areaName;
	}
	public String getAreaType() {
		return areaType;
	}
	public void setAreaType(String areaType) {
		this.areaType = areaType;
	}
	public String getAreaCode() {
		return areaCode;
	}
	public void setAreaCode(String areaCode) {
		this.areaCode = areaCode;
	}
	public String getIsO2OArea() {
		return isO2OArea;
	}
	public void setIsO2OArea(String isO2OArea) {
		this.isO2OArea = isO2OArea;
	}
	public String getParentAreaName() {
		return parentAreaName;
	}
	public void setParentAreaName(String parentAreaName) {
		this.parentAreaName = parentAreaName;
	}
	public String getParentAreaType() {
		return parentAreaType;
	}
	public void setParentAreaType(String parentAreaType) {
		this.parentAreaType = parentAreaType;
	}
	public String getActualCity() {
		return actualCity;
	}
	public void setActualCity(String actualCity) {
		this.actualCity = actualCity;
	}
	public String getActualCityType() {
		return actualCityType;
	}
	public void setActualCityType(String actualCityType) {
		this.actualCityType = actualCityType;
	}
	public String getOrgOnName() {
		return orgOnName;
	}
	public void setOrgOnName(String orgOnName) {
		this.orgOnName = orgOnName;
	}
	public String getIsO2ODistrict() {
		return isO2ODistrict;
	}
	public void setIsO2ODistrict(String isO2ODistrict) {
		this.isO2ODistrict = isO2ODistrict;
	}
	
	
	

}
