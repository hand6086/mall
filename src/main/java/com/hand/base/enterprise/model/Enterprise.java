package com.hand.base.enterprise.model;

import com.hand.base.basic.model.BasicModel;

public class Enterprise extends BasicModel {

	private static final long serialVersionUID = -9207789001141007013L;
	private String code; /* 企业编号 */
	private String name; /* 名称 */
	private String comments; /* 说明 */

	public static long getSerialVersionUID() {
		return serialVersionUID;
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

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
}
