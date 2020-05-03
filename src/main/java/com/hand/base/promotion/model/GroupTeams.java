package com.hand.base.promotion.model;

import com.hand.base.basic.model.BasicModel;

/**
 * 拼团 列表
 * 
 * @author guo
 *
 */
public class GroupTeams extends BasicModel {

	private static final long serialVersionUID = 2031816762227903706L;

	private String cityId;
	private String activityName;/* 促销活动名称 */
	private String code;/* 促销活动编码 */
	private String schemaId;/* 活动方案ID */
	private String buyMerchName;/* 购买商品名称 */
	private String merchCode;/* 商品编码 */
	private Double groupsNumber;/* 拼团人数 */
	private Double teamNum;/* 已拼人数 */
	private Double lackNum;/* 未拼人数 */
	private String startTime;/* 成团时间 */
	private Double effectiveDuration;/* 成团有效时间 */
	private String status;/* 拼团状态 */
	private String activityId;/* 拼团活动ID */
	private String merchandiseId;/* 拼团商品ID */

	public String getCityId() {
		return cityId;
	}

	public void setCityId(String cityId) {
		this.cityId = cityId;
	}

	public String getActivityName() {
		return activityName;
	}

	public void setActivityName(String activityName) {
		this.activityName = activityName;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getSchemaId() {
		return schemaId;
	}

	public void setSchemaId(String schemaId) {
		this.schemaId = schemaId;
	}

	public String getBuyMerchName() {
		return buyMerchName;
	}

	public void setBuyMerchName(String buyMerchName) {
		this.buyMerchName = buyMerchName;
	}

	public String getMerchCode() {
		return merchCode;
	}

	public void setMerchCode(String merchCode) {
		this.merchCode = merchCode;
	}

	public Double getGroupsNumber() {
		return groupsNumber;
	}

	public void setGroupsNumber(Double groupsNumber) {
		this.groupsNumber = groupsNumber;
	}

	public Double getTeamNum() {
		return teamNum;
	}

	public void setTeamNum(Double teamNum) {
		this.teamNum = teamNum;
	}

	public Double getLackNum() {
		return lackNum;
	}

	public void setLackNum(Double lackNum) {
		this.lackNum = lackNum;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public Double getEffectiveDuration() {
		return effectiveDuration;
	}

	public void setEffectiveDuration(Double effectiveDuration) {
		this.effectiveDuration = effectiveDuration;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getActivityId() {
		return activityId;
	}

	public void setActivityId(String activityId) {
		this.activityId = activityId;
	}

	public String getMerchandiseId() {
		return merchandiseId;
	}

	public void setMerchandiseId(String merchandiseId) {
		this.merchandiseId = merchandiseId;
	}

}