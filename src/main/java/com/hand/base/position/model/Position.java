package com.hand.base.position.model;

import java.util.List;

import com.hand.base.basic.model.BasicModel;

public class Position extends BasicModel{

	private String text;//职位名称
	//private String postnName;//职位名称
	private String positionType;
	private String positionTypeLovType;
	private String parentPositionId;
	private String parentPositionName;
	private String isEffective;
	private String isEffectiveLovType;
	private String deptId;
	private String deptName;
	private List<Position> children;
	private String acctId;
	/**组织名*/
	private String orgName;
	private String userId;
	/**中间表id*/
	private String interId;
	/**是否为默认值*/
	private String isDefault;
	/**用户名*/
	private String username;
	/**姓名*/
	private String fstName;
	private String empTel;//用户电话
	private String status;
	private String errorMessage;
	
	private String integrationId; //集成ID
	private String source; //来源
	private String corpName;//公司账套
	
	
	public String getCorpName() {
		return corpName;
	}

	public void setCorpName(String corpName) {
		this.corpName = corpName;
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

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getErrorMessage() {
		return errorMessage;
	}

	public void setErrorMessage(String errorMessage) {
		this.errorMessage = errorMessage;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getPositionType() {
		return positionType;
	}

	public void setPositionType(String positionType) {
		this.positionType = positionType;
	}

	public String getParentPositionId() {
		return parentPositionId;
	}

	public void setParentPositionId(String parentPositionId) {
		this.parentPositionId = parentPositionId;
	}

	public String getIsEffective() {
		return isEffective;
	}

	public void setIsEffective(String isEffective) {
		this.isEffective = isEffective;
	}

	public String getParentPositionName() {
		return parentPositionName;
	}

	public void setParentPositionName(String parentPositionName) {
		this.parentPositionName = parentPositionName;
	}

	public List<Position> getChildren() {
		return children;
	}

	public void setChildren(List<Position> children) {
		this.children = children;
	}

	public String getDeptId() {
		return deptId;
	}

	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	public String getPositionTypeLovType() {
		return positionTypeLovType;
	}

	public void setPositionTypeLovType(String positionTypeLovType) {
		this.positionTypeLovType = positionTypeLovType;
	}

	public String getIsEffectiveLovType() {
		return isEffectiveLovType;
	}

	public void setIsEffectiveLovType(String isEffectiveLovType) {
		this.isEffectiveLovType = isEffectiveLovType;
	}

	public String getOrgName() {
		return orgName;
	}

	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}

	public String getAcctId() {
		return acctId;
	}

	public void setAcctId(String acctId) {
		this.acctId = acctId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getInterId() {
		return interId;
	}

	public void setInterId(String interId) {
		this.interId = interId;
	}

	public String getIsDefault() {
		return isDefault;
	}

	public void setIsDefault(String isDefault) {
		this.isDefault = isDefault;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getFstName() {
		return fstName;
	}

	public void setFstName(String fstName) {
		this.fstName = fstName;
	}

	public String getEmpTel() {
		return empTel;
	}

	public void setEmpTel(String empTel) {
		this.empTel = empTel;
	}
	
}
