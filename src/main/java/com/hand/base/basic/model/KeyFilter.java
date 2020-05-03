package com.hand.base.basic.model;

import java.io.Serializable;

import com.hand.core.basic.query.Filter;


public class KeyFilter implements Serializable{
	
	private static final long serialVersionUID = -2913657518815087969L;
	private String id;
	private String name;
	private String operator = Filter.OP_EQUAL;
	private String value;
	private Boolean selected;
	private Integer recordCount;
	
	public KeyFilter(){
		
	}
	
	public KeyFilter(String name, String value) {
		this.name = name;
		this.value = value;
	}

	public KeyFilter(String name, String value,Boolean selected) {
		this.name = name;
		this.value = value;
		this.selected = selected;
	}
	
	public KeyFilter(String name, String value, Integer recordCount) {
		this.name = name;
		this.value = value;
		this.recordCount = recordCount;
	}
	
	public KeyFilter(String name, String operator, String value) {
		this.name = name;
		this.operator = operator;
		this.value = value;
	}
	
	
	public KeyFilter(String name, String operator, String value, Integer recordCount) {
		this.name = name;
		this.operator = operator;
		this.value = value;
		this.recordCount = recordCount;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getOperator() {
		return operator;
	}

	public void setOperator(String operator) {
		this.operator = operator;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public Integer getRecordCount() {
		return recordCount;
	}

	public void setRecordCount(Integer recordCount) {
		this.recordCount = recordCount;
	}

	public Boolean getSelected() {
		return selected;
	}

	public void setSelected(Boolean selected) {
		this.selected = selected;
	}

}