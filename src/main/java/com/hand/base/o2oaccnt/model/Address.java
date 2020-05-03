package com.hand.base.o2oaccnt.model;

import com.hand.base.basic.model.BasicModel;

public class Address extends BasicModel {
	private String custmName; /* 消费者名称 */
	private String custmCode; /* 消费者编码 */
	private String custmPhone; /* 消费者电话 */
	private String isPredefault; /* 是否默认地址 */
	private String province;/* 省/直辖市 */
	private String city;/* 城市 */
	private String district;/* 区/县 */
	private String address;/* 详细地址 */
	private String contact;/* 收货人姓名 */
	private String contPhone;/* 收货人电话 */
	private String gpsLong;/* GPS经度 */
	private String gpsLat;/* GPS纬度 */
	private String postCode;/* 邮政编码 */
	private String labelName;/* 地址标签 */
	private String status;/* 状态 */
	private String custId;
	private String labelId;//地址标签ID
	private String addressType;//地址类型
	
	
	public String getCustId() {
		return custId;
	}
	public void setCustId(String custId) {
		this.custId = custId;
	}
	
	public String getCustmName() {
		return custmName;
	}
	public void setCustmName(String custmName) {
		this.custmName = custmName;
	}
	public String getCustmCode() {
		return custmCode;
	}
	public void setCustmCode(String custmCode) {
		this.custmCode = custmCode;
	}
	public String getCustmPhone() {
		return custmPhone;
	}
	public void setCustmPhone(String custmPhone) {
		this.custmPhone = custmPhone;
	}
	public String getIsPredefault() {
		return isPredefault;
	}
	public void setIsPredefault(String isPredefault) {
		this.isPredefault = isPredefault;
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
	public String getContPhone() {
		return contPhone;
	}
	public void setContPhone(String contPhone) {
		this.contPhone = contPhone;
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
	public String getPostCode() {
		return postCode;
	}
	public void setPostCode(String postCode) {
		this.postCode = postCode;
	}
	public String getLabelName() {
		return labelName;
	}
	public void setLabelName(String labelName) {
		this.labelName = labelName;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getLabelId() {
		return labelId;
	}
	public void setLabelId(String labelId) {
		this.labelId = labelId;
	}
	public String getAddressType() {
		return addressType;
	}
	public void setAddressType(String addressType) {
		this.addressType = addressType;
	}
	
	
	

}
