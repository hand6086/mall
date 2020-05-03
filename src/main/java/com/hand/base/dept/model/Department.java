package com.hand.base.dept.model;

import java.util.List;

import com.hand.base.basic.model.BasicModel;

public class Department extends BasicModel{

	private String deptCode;
	/** 树节点显示名称 */
	private String text;
	private String deptType;
	private String deptTypeLovType;
	private String parentDeptId;
	private String parentDeptName;
	private String orgId;
	private String orgName;
	private String isEffective;
	private String isEffectiveLovType;
	private String isOrg;//组织标记
	
	private String integrationId; /* 集成ID*/
	private String source; /*数据来源 */
	
	private List<Department> children;

	
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

	public String getDeptCode() {
		return deptCode;
	}

	public void setDeptCode(String deptCode) {
		this.deptCode = deptCode;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getDeptType() {
		return deptType;
	}

	public void setDeptType(String deptType) {
		this.deptType = deptType;
	}

	public String getParentDeptId() {
		return parentDeptId;
	}

	public void setParentDeptId(String parentDeptId) {
		this.parentDeptId = parentDeptId;
	}

	public String getParentDeptName() {
		return parentDeptName;
	}

	public void setParentDeptName(String parentDeptName) {
		this.parentDeptName = parentDeptName;
	}

	public String getOrgId() {
		return orgId;
	}

	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}

	public String getOrgName() {
		return orgName;
	}

	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}

	public String getIsEffective() {
		return isEffective;
	}

	public void setIsEffective(String isEffective) {
		this.isEffective = isEffective;
	}

	public List<Department> getChildren() {
		return children;
	}

	public void setChildren(List<Department> children) {
		this.children = children;
	}

	public String getDeptTypeLovType() {
		return deptTypeLovType;
	}

	public void setDeptTypeLovType(String deptTypeLovType) {
		this.deptTypeLovType = deptTypeLovType;
	}

	public String getIsEffectiveLovType() {
		return isEffectiveLovType;
	}

	public void setIsEffectiveLovType(String isEffectiveLovType) {
		this.isEffectiveLovType = isEffectiveLovType;
	}

	public String getIsOrg() {
		return isOrg;
	}

	public void setIsOrg(String isOrg) {
		this.isOrg = isOrg;
	}

}
