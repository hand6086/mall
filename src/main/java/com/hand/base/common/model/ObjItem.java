package com.hand.base.common.model;

import java.util.Date;

import com.hand.base.basic.model.BasicModel;

public class ObjItem extends BasicModel{
	
	private String objItemName;
	
	private String objItemType;
	
	private Date objItemDate;
	
	private Double ObjItemNum;
	
	private String comments;
	
	private String headId;

	public String getObjItemName() {
		return objItemName;
	}

	public void setObjItemName(String objItemName) {
		this.objItemName = objItemName;
	}

	public String getObjItemType() {
		return objItemType;
	}

	public void setObjItemType(String objItemType) {
		this.objItemType = objItemType;
	}

	public Date getObjItemDate() {
		return objItemDate;
	}

	public void setObjItemDate(Date objItemDate) {
		this.objItemDate = objItemDate;
	}

	public Double getObjItemNum() {
		return ObjItemNum;
	}

	public void setObjItemNum(Double objItemNum) {
		ObjItemNum = objItemNum;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}

	public String getHeadId() {
		return headId;
	}

	public void setHeadId(String headId) {
		this.headId = headId;
	}
}
