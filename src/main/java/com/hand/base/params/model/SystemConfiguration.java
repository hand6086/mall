package com.hand.base.params.model;

import com.hand.base.basic.model.BasicModel;

/**
 * O2O参数设置-系统配置
 */
public class SystemConfiguration extends BasicModel {
	private String name;// 名称
	private String code;// 编码
	private String value;// 值
	private String tAttr01;// 短信平台切换
	private String notes; // 说明

	public SystemConfiguration() {
		super();
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String gettAttr01() {
		return tAttr01;
	}

	public void settAttr01(String tAttr01) {
		this.tAttr01 = tAttr01;
	}

	public String getNotes() {
		return notes;
	}

	public void setNotes(String notes) {
		this.notes = notes;
	}

}
