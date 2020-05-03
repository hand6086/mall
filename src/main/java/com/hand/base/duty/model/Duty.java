package com.hand.base.duty.model;


import com.hand.base.basic.model.BasicModel;

public class Duty extends BasicModel{

	private String name;
	
	private String comments;
	
	private String isDefault;
	
	private String corpName;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}

	public String getIsDefault() {
		return isDefault;
	}

	public void setIsDefault(String isDefault) {
		this.isDefault = isDefault;
	}

	public String getCorpName() {
		return corpName;
	}

	public void setCorpName(String corpName) {
		this.corpName = corpName;
	}
	
	
}
