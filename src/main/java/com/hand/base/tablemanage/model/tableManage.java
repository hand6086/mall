package com.hand.base.tablemanage.model;

import com.hand.base.basic.model.BasicModel;

public class tableManage extends BasicModel {
	private String tableName;
	private String tComment;
	private String fieldName;
	private String fComment;
	private String headId;
	public String getTableName() {
		return tableName;
	}
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	public String gettComment() {
		return tComment;
	}
	public void settComment(String tComment) {
		this.tComment = tComment;
	}
	public String getFieldName() {
		return fieldName;
	}
	public void setFieldName(String fieldName) {
		this.fieldName = fieldName;
	}
	public String getfComment() {
		return fComment;
	}
	public void setfComment(String fComment) {
		this.fComment = fComment;
	}
	public String getHeadId() {
		return headId;
	}
	public void setHeadId(String headId) {
		this.headId = headId;
	}
	
	
	
}
