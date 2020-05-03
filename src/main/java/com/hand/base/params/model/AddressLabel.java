package com.hand.base.params.model;

import com.hand.base.basic.model.BasicModel;

/**
 * O2O参数设置-地址标签
 *
 */
public class AddressLabel extends BasicModel {
	private String labelActive;// 是否有效
	private String labelComments; // 备注
	private String labelName; // 地址标签名称

	public AddressLabel() {
		super();
	}

	public String getLabelActive() {
		return labelActive;
	}

	public void setLabelActive(String labelActive) {
		this.labelActive = labelActive;
	}

	public String getLabelComments() {
		return labelComments;
	}

	public void setLabelComments(String labelComments) {
		this.labelComments = labelComments;
	}

	public String getLabelName() {
		return labelName;
	}

	public void setLabelName(String labelName) {
		this.labelName = labelName;
	}

}
