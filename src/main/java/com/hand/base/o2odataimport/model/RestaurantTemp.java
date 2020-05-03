package com.hand.base.o2odataimport.model;

import com.hand.base.basic.model.BasicModel;
import com.hand.core.util.AppConstants;

public class RestaurantTemp extends BasicModel {
	/**
	 * 餐厅导入
	 */
	private static final long serialVersionUID = 2088075916014169111L;
	private String checkStatus;/*
								 * 校验状态picklist:TB Check Status ,Expr:
								 * 'LookupValue("TB_CHECK_STATUS","New")'
								 */
	private String impStatus;/*
								 * 导入状态TB Import Status,Expr:
								 * 'LookupValue("TB_IMPORT_STATUS","New")'
								 */
	private String errMessage;/* 错误信息 */
	private String  name;/*餐厅名称*/
	private String  logo;/*LogoId*/
	private String  logoUrl;/*Logo图片*/
	private String  province;/*省/直辖市*/
	private String  city;/*市*/
	private String  district;/*区/县*/
	private String  street;/*街道*/
	private String  address;/*详细地址*/
	private String  phone;/*餐厅电话*/
	private String  merchantsName;/*配送商名称*/
	private String  merchantsContact;/*配送商联系人*/
	private String  merchantsPhone;/*配送商联系方式*/
	
	private Double latitude;/*纬度*/
	private Double longtitude;/*经度*/
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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getLogo() {
		return logo;
	}

	public void setLogo(String logo) {
		this.logo = logo;
	}

	public String getLogoUrl() {
		if (logoUrl != null && !"".equals(logoUrl)) {
			return AppConstants.portalSharePicHttpDir+logoUrl;
		} else {
			return logoUrl;
		}
	}

	public void setLogoUrl(String logoUrl) {
		this.logoUrl = logoUrl;
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

	public String getStreet() {
		return street;
	}

	public void setStreet(String street) {
		this.street = street;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getMerchantsName() {
		return merchantsName;
	}

	public void setMerchantsName(String merchantsName) {
		this.merchantsName = merchantsName;
	}

	public String getMerchantsContact() {
		return merchantsContact;
	}

	public void setMerchantsContact(String merchantsContact) {
		this.merchantsContact = merchantsContact;
	}

	public String getMerchantsPhone() {
		return merchantsPhone;
	}

	public void setMerchantsPhone(String merchantsPhone) {
		this.merchantsPhone = merchantsPhone;
	}

	public Double getLatitude() {
		return latitude;
	}

	public void setLatitude(Double latitude) {
		this.latitude = latitude;
	}

	public Double getLongtitude() {
		return longtitude;
	}

	public void setLongtitude(Double longtitude) {
		this.longtitude = longtitude;
	}
}
