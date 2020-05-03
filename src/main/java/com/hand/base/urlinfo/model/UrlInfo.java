package com.hand.base.urlinfo.model;

import com.hand.base.basic.model.BasicModel;

public class UrlInfo extends BasicModel{

	private String url;                	/*URL*/
	private String name;               	/*名称*/
	private String comments;           	/*备注*/
	private String insertFlag;         	/*添加*/
	private String delFlag;            	/*删除*/
	private String updateFlag;         	/*修改*/
	private String selectFlag;         	/*查询*/
	private String defaultAccessFlag;  	/*默认可访问*/
	private String type; /*URL 类型 区分来源 CRM/app/others */
	
	

	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}

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

	public String getInsertFlag() {
		return insertFlag;
	}
	public void setInsertFlag(String insertFlag) {
		this.insertFlag = insertFlag;
	}

	public String getDelFlag() {
		return delFlag;
	}
	public void setDelFlag(String delFlag) {
		this.delFlag = delFlag;
	}

	public String getUpdateFlag() {
		return updateFlag;
	}
	public void setUpdateFlag(String updateFlag) {
		this.updateFlag = updateFlag;
	}

	public String getSelectFlag() {
		return selectFlag;
	}
	public void setSelectFlag(String selectFlag) {
		this.selectFlag = selectFlag;
	}

	public String getDefaultAccessFlag() {
		return defaultAccessFlag;
	}
	public void setDefaultAccessFlag(String defaultAccessFlag) {
		this.defaultAccessFlag = defaultAccessFlag;
	}



}
