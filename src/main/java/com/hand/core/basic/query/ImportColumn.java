package com.hand.core.basic.query;

import java.util.Map;

public class ImportColumn implements Comparable<ImportColumn>{
	private String title;
	private String field;
	private Integer order;
	private String parentid;
	private String parentField;
	
	private String lov;//值列表类型
	
	private Map<String,String> lovMap;//值列表
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getField() {
		return field;
	}
	public void setField(String field) {
		this.field = field;
	}
	public Integer getOrder() {
		return order;
	}
	public void setOrder(Integer order) {
		this.order = order;
	}
	
	public int compareTo(ImportColumn arg0) {
		return this.getOrder().compareTo(arg0.getOrder());
	}
	public String getParentid() {
		return parentid;
	}
	public void setParentid(String parentid) {
		this.parentid = parentid;
	}
	public String getParentField() {
		return parentField;
	}
	public void setParentField(String parentField) {
		this.parentField = parentField;
	}
	public String getLov() {
		return lov;
	}
	public void setLov(String lov) {
		this.lov = lov;
	}
	public Map<String, String> getLovMap() {
		return lovMap;
	}
	public void setLovMap(Map<String, String> lovMap) {
		this.lovMap = lovMap;
	}
	
}
