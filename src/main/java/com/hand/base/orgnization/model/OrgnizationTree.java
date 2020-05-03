package com.hand.base.orgnization.model;

import java.util.List;

public class OrgnizationTree{

	private String id;
	
	private String text;
	
	private List<OrgnizationTree> children;

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

	public List<OrgnizationTree> getChildren() {
		return children;
	}

	public void setChildren(List<OrgnizationTree> children) {
		this.children = children;
	}

}
