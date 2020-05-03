package com.hand.base.o2oaddress.model;

import com.hand.base.basic.model.BasicModel;

public class O2OAddress extends BasicModel {

	/**
	 * 地址
	 */
	private static final long serialVersionUID = -3634639299229033662L;
	private String areaName; /* 区域名称 */
	private String areaType; /* 区域类型 */
	private String areaCode; /* 区域编码 */
	private String parentId; /* 父区域id */
	private String parentAreaName;
	private String parentAreaName2;
	private String[] ids;
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
	public String getParentId() {
		return parentId;
	}
	public void setParentId(String parentId) {
		this.parentId = parentId;
	}
	public String getParentAreaName() {
		return parentAreaName;
	}
	public void setParentAreaName(String parentAreaName) {
		this.parentAreaName = parentAreaName;
	}
	public String getParentAreaName2() {
		return parentAreaName2;
	}
	public void setParentAreaName2(String parentAreaName2) {
		this.parentAreaName2 = parentAreaName2;
	}
	
	public String[] getIds() {
		return ids;
	}
	public void setIds(String[] ids) {
		this.ids = ids;
	}
	
	
}
