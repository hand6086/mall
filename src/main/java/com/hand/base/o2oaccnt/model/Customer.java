package com.hand.base.o2oaccnt.model;

import com.hand.base.basic.model.BasicModel;

public class Customer extends BasicModel {

	/**
	 * 
	 */
	private static final long serialVersionUID = -8161129656819458394L;
	private String custmId;/* 消费者编码 */
	private String custmName;/* 姓名 */
	private String custmPhone;/* 手机号 */
	private String isActiveUser; /*是否活跃用户*/
	private String inviteCode; /* 邀请码 */
	private String custmType;/* 类型 */
	private String custmSource;/* 消费者来源 */
	private String isEmployee;/* 是否员工 */
	private String isRegisted;/* 是否在APP注册 */
	private String city;/* 注册城市 */
	private String inviteName;/* 邀请人 */
	private String invitePhone;/* 邀请人手机号 */
	private String inviteCode2;/* 邀请人邀请码 */
	private String invitedTime;/*邀请时间*/
	private String invitedStatus; /*邀请状态*/
	private String invitedType;/*邀请方式*/
	private String invitedPhone; /*被邀请人电话*/
	private String inviterId; /*邀请人id*/
	private String parRowId;
	private String t2RowId;
	private String createdTime;/* 注册时间 */
	private String createdStart;/* 注册开始时间 */
	private String createdEnd;/* 注册结束时间 */
	private String t4RowId;
	private String t5RowId;
	private String attrIb159;
	private String id2;
	
	

	public String getId2() {
		return id2;
	}
	public void setId2(String id2) {
		this.id2 = id2;
	}
	public String getAttrIb159() {
		return attrIb159;
	}
	public void setAttrIb159(String attrIb159) {
		this.attrIb159 = attrIb159;
	}
	public String getT4RowId() {
		return t4RowId;
	}
	public void setT4RowId(String t4RowId) {
		this.t4RowId = t4RowId;
	}
	public String getT5RowId() {
		return t5RowId;
	}
	public void setT5RowId(String t5RowId) {
		this.t5RowId = t5RowId;
	}
	public String getCreatedTime() {
		return createdTime;
	}
	public void setCreatedTime(String createdTime) {
		this.createdTime = createdTime;
	}
	public String getCreatedStart() {
		return createdStart;
	}
	public void setCreatedStart(String createdStart) {
		this.createdStart = createdStart;
	}
	public String getCreatedEnd() {
		return createdEnd;
	}
	public void setCreatedEnd(String createdEnd) {
		this.createdEnd = createdEnd;
	}
	public String getParRowId() {
		return parRowId;
	}
	public String getT2RowId() {
		return t2RowId;
	}
	public void setT2RowId(String t2RowId) {
		this.t2RowId = t2RowId;
	}
	public void setParRowId(String parRowId) {
		this.parRowId = parRowId;
	}
	public String getCustmId() {
		return custmId;
	}
	public void setCustmId(String custmId) {
		this.custmId = custmId;
	}
	public String getCustmName() {
		return custmName;
	}
	public void setCustmName(String custmName) {
		this.custmName = custmName;
	}
	public String getCustmPhone() {
		return custmPhone;
	}
	public void setCustmPhone(String custmPhone) {
		this.custmPhone = custmPhone;
	}
	public String getInviteCode() {
		return inviteCode;
	}
	public void setInviteCode(String inviteCode) {
		this.inviteCode = inviteCode;
	}
	public String getCustmType() {
		return custmType;
	}
	public void setCustmType(String custmType) {
		this.custmType = custmType;
	}
	public String getCustmSource() {
		return custmSource;
	}
	public void setCustmSource(String custmSource) {
		this.custmSource = custmSource;
	}
	public String getIsEmployee() {
		return isEmployee;
	}
	public void setIsEmployee(String isEmployee) {
		this.isEmployee = isEmployee;
	}
	public String getIsRegisted() {
		return isRegisted;
	}
	public void setIsRegisted(String isRegisted) {
		this.isRegisted = isRegisted;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getInviteName() {
		return inviteName;
	}
	public void setInviteName(String inviteName) {
		this.inviteName = inviteName;
	}
	public String getInvitePhone() {
		return invitePhone;
	}
	public void setInvitePhone(String invitePhone) {
		this.invitePhone = invitePhone;
	}
	public String getInviteCode2() {
		return inviteCode2;
	}
	public void setInviteCode2(String inviteCode2) {
		this.inviteCode2 = inviteCode2;
	}
	public String getInvitedTime() {
		return invitedTime;
	}
	public void setInvitedTime(String invitedTime) {
		this.invitedTime = invitedTime;
	}
	public String getInvitedStatus() {
		return invitedStatus;
	}
	public void setInvitedStatus(String invitedStatus) {
		this.invitedStatus = invitedStatus;
	}
	public String getInvitedType() {
		return invitedType;
	}
	public void setInvitedType(String invitedType) {
		this.invitedType = invitedType;
	}
	public String getInvitedPhone() {
		return invitedPhone;
	}
	public void setInvitedPhone(String invitedPhone) {
		this.invitedPhone = invitedPhone;
	}
	public String getInviterId() {
		return inviterId;
	}
	public void setInviterId(String inviterId) {
		this.inviterId = inviterId;
	}

	public String getIsActiveUser() {
		return isActiveUser;
	}

	public void setIsActiveUser(String isActiveUser) {
		this.isActiveUser = isActiveUser;
	}
}
