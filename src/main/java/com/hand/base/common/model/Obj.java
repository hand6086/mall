package com.hand.base.common.model;

import java.util.Date;

import com.hand.base.basic.model.BasicModel;

public class Obj extends BasicModel{
	
	private String objName;
	
	private String objType;
	
	private Date objDate;
	
	private Double ObjNum;
	
	private String comments;

	public String getObjName() {
		return objName;
	}

	public void setObjName(String objName) {
		this.objName = objName;
	}

	public String getObjType() {
		return objType;
	}

	public void setObjType(String objType) {
		this.objType = objType;
	}

	public Date getObjDate() {
		return objDate;
	}

	public void setObjDate(Date objDate) {
		this.objDate = objDate;
	}

	public Double getObjNum() {
		return ObjNum;
	}

	public void setObjNum(Double objNum) {
		ObjNum = objNum;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}
	
}
