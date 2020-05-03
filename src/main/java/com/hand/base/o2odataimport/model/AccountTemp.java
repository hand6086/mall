package com.hand.base.o2odataimport.model;

import com.hand.base.basic.model.BasicModel;
import com.hand.base.user.model.User;
import com.hand.core.util.UserUtil;

public class AccountTemp extends BasicModel {
	private String checkStatus;/* 校验状态 */
	private String impStatus;/* 导入状态 */
	private String errMessage;/* 错误信息 */
	private String accntCode;/* 客户Siebel编码 */
	private String accntName;/* 客户名称 */
	private String type;/* 商户类型 */
	private String dsrType;/* 配送网点类型 */
	private String province;
	private String city;
	private String district;
	private String address;
	private String contact;
	private String cellPhone;
	private String dsrStatus; /* 状态 */
	private String gpsLong;
	private String gpsLat;
	private String isForcedStore; /* 是否兜底商户 */
	private String isGpStore; /* 是否团购商户 */
	private String channelType; /* 渠道类型 */
	private String orgId;

	public String getOrgId() {
		User user = UserUtil.getUser(null);
		orgId = user.getOrgId();
		return orgId;
	}

	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}

	public String getCheckStatus() {
		return checkStatus;
	}

	public void setCheckStatus(String checkStatus) {
		this.checkStatus = checkStatus;
	}

	public String getImpStatus() {
		return impStatus;
	}

	public void setImpStatus(String impStatus) {
		this.impStatus = impStatus;
	}

	public String getErrMessage() {
		return errMessage;
	}

	public void setErrMessage(String errMessage) {
		this.errMessage = errMessage;
	}

	public String getAccntCode() {
		return accntCode;
	}

	public void setAccntCode(String accntCode) {
		this.accntCode = accntCode;
	}

	public String getAccntName() {
		return accntName;
	}

	public void setAccntName(String accntName) {
		this.accntName = accntName;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getDsrType() {
		return dsrType;
	}

	public void setDsrType(String dsrType) {
		this.dsrType = dsrType;
	}

	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getDistrict() {
		return district;
	}

	public void setDistrict(String district) {
		this.district = district;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getContact() {
		return contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

	public String getCellPhone() {
		return cellPhone;
	}

	public void setCellPhone(String cellPhone) {
		this.cellPhone = cellPhone;
	}

	public String getDsrStatus() {
		return dsrStatus;
	}

	public void setDsrStatus(String dsrStatus) {
		this.dsrStatus = dsrStatus;
	}

	public String getGpsLong() {
		return gpsLong;
	}

	public void setGpsLong(String gpsLong) {
		this.gpsLong = gpsLong;
	}

	public String getGpsLat() {
		return gpsLat;
	}

	public void setGpsLat(String gpsLat) {
		this.gpsLat = gpsLat;
	}

	public String getIsForcedStore() {
		return isForcedStore;
	}

	public void setIsForcedStore(String isForcedStore) {
		this.isForcedStore = isForcedStore;
	}

	public String getIsGpStore() {
		return isGpStore;
	}

	public void setIsGpStore(String isGpStore) {
		this.isGpStore = isGpStore;
	}

	public String getChannelType() {
		return channelType;
	}

	public void setChannelType(String channelType) {
		this.channelType = channelType;
	}

}
