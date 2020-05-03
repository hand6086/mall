package com.hand.base.basic.model;

/**
 * 值列表
 * @author ZHENGHONGDA
 *
 */
public class ListOfValue extends BasicModel{
	
	private String name;			//显示值
	private String val;				//独立源代码
	private String type;			//类型
	private String langId;			//语言
	private String lang;			//语言
	private String activeFlag;		//有效标志
	private String seq;				//排序
	private String sapVal;			//sap独立源代码
	private String parentId;		//父对象ID
	private String parentName;		//父对象显示值
	private String parentVal;		//父对象独立源代码
	private String parentType;		//父对象类型
	private String comments;		//说明
	
	public ListOfValue() {}
	
	public String getSapVal() {
		return sapVal;
	}

	public void setSapVal(String sapVal) {
		this.sapVal = sapVal;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getVal() {
		return val;
	}

	public void setVal(String val) {
		this.val = val;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getLang() {
		return lang;
	}

	public void setLang(String lang) {
		this.lang = lang;
	}

	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	public String getLangId() {
		return langId;
	}

	public void setLangId(String langId) {
		this.langId = langId;
	}

	public String getActiveFlag() {
		return activeFlag;
	}

	public void setActiveFlag(String activeFlag) {
		this.activeFlag = activeFlag;
	}

	public String getParentName() {
		return parentName;
	}

	public void setParentName(String parentName) {
		this.parentName = parentName;
	}

	public String getSeq() {
		return seq;
	}

	public void setSeq(String seq) {
		this.seq = seq;
	}

	public String getParentVal() {
		return parentVal;
	}

	public void setParentVal(String parentVal) {
		this.parentVal = parentVal;
	}

	public String getParentType() {
		return parentType;
	}

	public void setParentType(String parentType) {
		this.parentType = parentType;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}
	
}
