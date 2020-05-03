package com.hand.base.orgnization.model;

import java.util.List;

import com.hand.base.basic.model.BasicModel;

public class Orgnization extends BasicModel {

	private String orgCode;
	/** 树节点显示名称 */
	private String text;
	/** 营销渠道 */
	private String marketChannel;
	private String orgType;
	/**  存放筛选类型 */
	private String orgTypeValue;
	private String orgTypeLovType;
	private String parentOrgId;
	private String parentOrgName;
	private String isEffective;
	private String isEffectiveLovType;
	private String carShelfLife;
	private String orgId;
	private String parentOrgCode;
	private String errorMessage; // 错误信息
	private String status; // 状态
	private String isOrg;// 组织标记
	private String qdDeptId; /* 企点部门ID */
	private String parentOrgQdDeptId; /* 父组织的企点部门ID */

	private String integrationId;
	private String source;
	
	private String acctId;
	private String acctName;
	
	
	
	public String getAcctId() {
		return acctId;
	}

	public void setAcctId(String acctId) {
		this.acctId = acctId;
	}

	public String getAcctName() {
		return acctName;
	}

	public void setAcctName(String acctName) {
		this.acctName = acctName;
	}

	public String getIntegrationId() {
		return integrationId;
	}

	public void setIntegrationId(String integrationId) {
		this.integrationId = integrationId;
	}

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}

	public String getErrorMessage() {
		return errorMessage;
	}

	public void setErrorMessage(String errorMessage) {
		this.errorMessage = errorMessage;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getCarShelfLife() {
		return carShelfLife;
	}

	public void setCarShelfLife(String carShelfLife) {
		this.carShelfLife = carShelfLife;
	}

	private List<Orgnization> children;// 注意:如果前端传了这个参数则会报400错误

	public String getOrgCode() {
		return orgCode;
	}

	public void setOrgCode(String orgCode) {
		this.orgCode = orgCode;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public List<Orgnization> getChildren() {
		return children;
	}

	public void setChildren(List<Orgnization> children) {
		this.children = children;
	}

	public String getOrgType() {
		return orgType;
	}

	public void setOrgType(String orgType) {
		this.orgType = orgType;
	}

	public String getParentOrgId() {
		return parentOrgId;
	}

	public void setParentOrgId(String parentOrgId) {
		this.parentOrgId = parentOrgId;
	}

	public String getIsEffective() {
		return isEffective;
	}

	public void setIsEffective(String isEffective) {
		this.isEffective = isEffective;
	}

	public String getParentOrgName() {
		return parentOrgName;
	}

	public void setParentOrgName(String parentOrgName) {
		this.parentOrgName = parentOrgName;
	}

	public String getOrgTypeLovType() {
		return orgTypeLovType;
	}

	public void setOrgTypeLovType(String orgTypeLovType) {
		this.orgTypeLovType = orgTypeLovType;
	}

	public String getIsEffectiveLovType() {
		return isEffectiveLovType;
	}

	public void setIsEffectiveLovType(String isEffectiveLovType) {
		this.isEffectiveLovType = isEffectiveLovType;
	}

	public String getMarketChannel() {
		return marketChannel;
	}

	public void setMarketChannel(String marketChannel) {
		this.marketChannel = marketChannel;
	}

	public String getOrgTypeValue() {
		return orgTypeValue;
	}

	public void setOrgTypeValue(String orgTypeValue) {
		this.orgTypeValue = orgTypeValue;
	}

	public String getOrgId() {
		return orgId;
	}

	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}

	public String getParentOrgCode() {
		return parentOrgCode;
	}

	public void setParentOrgCode(String parentOrgCode) {
		this.parentOrgCode = parentOrgCode;
	}

	public String getIsOrg() {
		return isOrg;
	}

	public void setIsOrg(String isOrg) {
		this.isOrg = isOrg;
	}

	public String getQdDeptId() {
		return qdDeptId;
	}

	public void setQdDeptId(String qdDeptId) {
		this.qdDeptId = qdDeptId;
	}

	public String getParentOrgQdDeptId() {
		return parentOrgQdDeptId;
	}

	public void setParentOrgQdDeptId(String parentOrgQdDeptId) {
		this.parentOrgQdDeptId = parentOrgQdDeptId;
	}

}
