package com.hand.base.params.model;

import com.hand.base.basic.model.BasicModel;

/**
 * O2O参数设置-评价标签
 *
 */
public class EvaluationLabel extends BasicModel {
	private String labelActive;
	private String labelComments;
	private String labelName;
	private String labelType;

	public EvaluationLabel() {
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

	public String getLabelType() {
		return labelType;
	}

	public void setLabelType(String labelType) {
		this.labelType = labelType;
	}

}
