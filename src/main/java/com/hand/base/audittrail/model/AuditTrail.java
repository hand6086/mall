package com.hand.base.audittrail.model;

import com.hand.base.basic.model.BasicModel;

/**
 * Model 审计追踪
 * @author hhx
 */
public class AuditTrail extends BasicModel {
	/**
	 * 员工登录ID
	 */
	private String userId;
	/**
	 * 工号
	 */
	private String userName;
	/**
	 * 员工姓名
	 */
	private String userFirstName;
	/**
	 * 业务组件
	 */
	private String buscompName;
	/**
	 * 字段
	 */
	private String field;
	/**
	 * 操作
	 */
	private String action;
	/**
	 * 旧值
	 */
	private String oldValue;
	/**
	 * 新值
	 */
	private String newValue;
	/**
	 * 日期
	 */
	private String dateTime;
	/**
	 * service
	 */
	private String service;
	/**
	 * 来源
	 */
	private String sourceName;
	/**
	 * 基本表
	 */
	private String baseTable;
	/**
	 * 子表名称
	 */
	private String childTable;
	/**
	 * 子值
	 */
	private String childValue;
	/**
	 * 列
	 */
	private String rowName;
	/**
	 * 同步日期
	 */
	private String synDate;
	/**
	 * 组ID
	 */
	private String groupId;
	/**
	 * 链接
	 */
	private String linkName;
	/**
	 * 节点
	 */
	private String node;
	/**
	 * 表
	 */
	private String tableName;
	/**
	 * 行标识
	 */
	private String lineFlag;

	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserFirstName() {
		return userFirstName;
	}
	public void setUserFirstName(String userFirstName) {
		this.userFirstName = userFirstName;
	}
	public String getBuscompName() {
		return buscompName;
	}
	public void setBuscompName(String buscompName) {
		this.buscompName = buscompName;
	}

	public String getField() {
		return field;
	}
	public void setField(String field) {
		this.field = field;
	}
	public String getAction() {
		return action;
	}
	public void setAction(String action) {
		this.action = action;
	}
	public String getOldValue() {
		return oldValue;
	}
	public void setOldValue(String oldValue) {
		this.oldValue = oldValue;
	}
	public String getNewValue() {
		return newValue;
	}
	public void setNewValue(String newValue) {
		this.newValue = newValue;
	}
	public String getDateTime() {
		return dateTime;
	}
	public void setDateTime(String dateTime) {
		this.dateTime = dateTime;
	}
	public String getService() {
		return service;
	}
	public void setService(String service) {
		this.service = service;
	}
	public String getSourceName() {
		return sourceName;
	}
	public void setSourceName(String sourceName) {
		this.sourceName = sourceName;
	}
	public String getBaseTable() {
		return baseTable;
	}
	public void setBaseTable(String baseTable) {
		this.baseTable = baseTable;
	}
	public String getChildTable() {
		return childTable;
	}
	public void setChildTable(String childTable) {
		this.childTable = childTable;
	}
	public String getChildValue() {
		return childValue;
	}
	public void setChildValue(String childValue) {
		this.childValue = childValue;
	}
	public String getRowName() {
		return rowName;
	}
	public void setRowName(String rowName) {
		this.rowName = rowName;
	}
	public String getSynDate() {
		return synDate;
	}
	public void setSynDate(String synDate) {
		this.synDate = synDate;
	}
	public String getGroupId() {
		return groupId;
	}
	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}
	public String getLinkName() {
		return linkName;
	}
	public void setLinkName(String linkName) {
		this.linkName = linkName;
	}
	public String getTableName() {
		return tableName;
	}
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	public String getNode() {
		return node;
	}
	public void setNode(String node) {
		this.node = node;
	}
	public String getLineFlag() {
		return lineFlag;
	}
	public void setLineFlag(String lineFlag) {
		this.lineFlag = lineFlag;
	}
	
	
}
