package com.hand.base.o2oaccnt.model;

import com.hand.base.basic.model.BasicModel;

public class AreaManager extends BasicModel {
	private String  areaName ;/*区域名称*/
	private String 	areaType ;/*区域类型*/
	private String 	areaCode ;/*区域编码*/
	private String  isO2OArea ;/*是否O2O平台区域*/
	private String 	parentAreaName; /*父区域名称*/
	private String 	parentAreaType ;/*父区域类型*/
	private String  actualCity;	/*真实名字*/
	private String  actualCityType; /*真实城市区域类型*/
	private String 	orgOnName; /*对应组织*/
	private String  isO2ODistrict ;/*是否地配区域*/
	private String 	parentId; /*父区域id*/
	private String  attr04; /*关联真实名字的字段*/
	private String	attr05; /*组织关联字段*/
	private String 	orgOnStatus; /*状态*/
	private String 	orgOnCode; /*组织编码*/
	private	String 	parOrgCode; /*父营销区域编码*/
	private String	parOrgName; /*父组织*/
	private String areaImgId;
	private String orgId; /*组织id*/
	
	
	
	public String getOrgId() {
		return orgId;
	}
	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}
	public String getAreaImgId() {
		return areaImgId;
	}
	public void setAreaImgId(String areaImgId) {
		this.areaImgId = areaImgId;
	}
	public String getAttr05() {
		return attr05;
	}
	public void setAttr05(String attr05) {
		this.attr05 = attr05;
	}
	public String getOrgOnStatus() {
		return orgOnStatus;
	}
	public void setOrgOnStatus(String orgOnStatus) {
		this.orgOnStatus = orgOnStatus;
	}
	public String getOrgOnCode() {
		return orgOnCode;
	}
	public void setOrgOnCode(String orgOnCode) {
		this.orgOnCode = orgOnCode;
	}
	public String getParOrgCode() {
		return parOrgCode;
	}
	public void setParOrgCode(String parOrgCode) {
		this.parOrgCode = parOrgCode;
	}
	public String getParOrgName() {
		return parOrgName;
	}
	public void setParOrgName(String parOrgName) {
		this.parOrgName = parOrgName;
	}
	public String getParentId() {
		return parentId;
	}
	public void setParentId(String parentId) {
		this.parentId = parentId;
	}
	public String getAttr04() {
		return attr04;
	}
	public void setAttr04(String attr04) {
		this.attr04 = attr04;
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
