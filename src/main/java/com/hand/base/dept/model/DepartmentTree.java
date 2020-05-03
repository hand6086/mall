package com.hand.base.dept.model;

import java.util.List;

public class DepartmentTree{

	private String id;
	
	private String text;
	
	private List<DepartmentTree> children;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public List<DepartmentTree> getChildren() {
		return children;
	}

	public void setChildren(List<DepartmentTree> children) {
		this.children = children;
	}

}
