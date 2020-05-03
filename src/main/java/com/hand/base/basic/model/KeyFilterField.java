package com.hand.base.basic.model;

import java.io.Serializable;
import java.util.List;
import java.util.Map;


public class KeyFilterField implements Serializable{

	private static final long serialVersionUID = 3060952184644297898L;
	private String id;
	private String filterField;
	private String title;
	private Map<String,Boolean> keyFilterMap;
	private List<KeyFilter> keyFilterList;
	
	public KeyFilterField(){
		
	};
	
	public KeyFilterField(String filterField, String title) {
		this.filterField = filterField;
		this.title = title;
	}
	
	public KeyFilterField(String id, String filterField, String title) {
		this.id = id;
		this.filterField = filterField;
		this.title = title;
	}



	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getFilterField() {
		return filterField;
	}
	public void setFilterField(String filterField) {
		this.filterField = filterField;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}

	public Map<String, Boolean> getKeyFilterMap() {
		return keyFilterMap;
	}

	public void setKeyFilterMap(Map<String, Boolean> keyFilterMap) {
		this.keyFilterMap = keyFilterMap;
	}

	public List<KeyFilter> getKeyFilterList() {
		return keyFilterList;
	}

	public void setKeyFilterList(List<KeyFilter> keyFilterList) {
		this.keyFilterList = keyFilterList;
	}

}