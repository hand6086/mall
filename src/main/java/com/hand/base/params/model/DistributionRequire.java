package com.hand.base.params.model;

import com.hand.base.basic.model.BasicModel;

/**
 * O2O参数设置-配送要求
 *
 */
public class DistributionRequire extends BasicModel {
	private String claimName;// 配送要求名称
	private String activeFlag;// 是否有效
	private String claimComments;// 备注

	public DistributionRequire() {
		super();
	}

	public String getClaimName() {
		return claimName;
	}

	public void setClaimName(String claimName) {
		this.claimName = claimName;
	}

	public String getActiveFlag() {
		return activeFlag;
	}

	public void setActiveFlag(String activeFlag) {
		this.activeFlag = activeFlag;
	}

	public String getClaimComments() {
		return claimComments;
	}

	public void setClaimComments(String claimComments) {
		this.claimComments = claimComments;
	}

}
