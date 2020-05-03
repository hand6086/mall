package com.hand.base.doc.model;

import com.hand.base.basic.model.BasicModel;

public class LnkDocResult extends BasicModel{

	private String type;               	/*类型*/
	private String ifNecessary;        	/*是否必要*/
	private String menuLineId;         	/*与主菜单line表的关联条件*/
	private String paramName;          	/*名称*/
	private String param;              	/*参数*/
	private String menuDescribe;           	/*描述*/


	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}

	public String getIfNecessary() {
		return ifNecessary;
	}
	public void setIfNecessary(String ifNecessary) {
		this.ifNecessary = ifNecessary;
	}

	public String getMenuLineId() {
		return menuLineId;
	}
	public void setMenuLineId(String menuLineId) {
		this.menuLineId = menuLineId;
	}

	public String getParamName() {
		return paramName;
	}
	public void setParamName(String paramName) {
		this.paramName = paramName;
	}

	public String getParam() {
		return param;
	}
	public void setParam(String param) {
		this.param = param;
	}

	
	public String getMenuDescribe() {
		return menuDescribe;
	}
	public void setMenuDescribe(String menuDescribe) {
		this.menuDescribe = menuDescribe;
	}



}
