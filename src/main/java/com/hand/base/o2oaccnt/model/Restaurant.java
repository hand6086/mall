
package com.hand.base.o2oaccnt.model;

import com.hand.base.basic.model.BasicModel;
import com.hand.core.util.AppConstants;

public class Restaurant extends BasicModel {
	
	/**
	 * 餐厅列表
	 */
	private static final long serialVersionUID = 4921943479040103344L;
	private String name;/*餐厅名称*/
	private String logoId;/*Logo图片id*/
	private String logoUrl;/*Logo图片URL*/
	private String provinceId;/*省/直辖市id*/
	private String province;/*省/直辖市*/
	private String cityId;/*市id*/
	private String city;/*市*/
	private String districtId;/*区/县id*/
	private String district;/*区/县*/
	private String street;/*街道*/
	private String address;/*详细地址*/
	private String phone;/*餐厅电话*/
	private String merchantsId;/*配送商id*/
	private String merchantsName;/*配送商名称*/
	private String merchantsContact;/*配送商联系人*/
	private String merchantsPhone;/*配送商联系方式*/
	private String status; /*状态*/
	private Double longtitude; /*经度*/
	private Double latitude; /*纬度*/
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getLogoId() {
		return logoId;
	}
	public void setLogoId(String logoId) {
		this.logoId = logoId;
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
	public String getProvinceId() {
		return provinceId;
	}
	public void setProvinceId(String provinceId) {
		this.provinceId = provinceId;
	}
	public String getProvince() {
		return province;
	}
	public void setProvince(String province) {
		this.province = province;
	}
	public String getCityId() {
		return cityId;
	}
	public void setCityId(String cityId) {
		this.cityId = cityId;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getDistrictId() {
		return districtId;
	}
	public void setDistrictId(String districtId) {
		this.districtId = districtId;
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
	public String getMerchantsId() {
		return merchantsId;
	}
	public void setMerchantsId(String merchantsId) {
		this.merchantsId = merchantsId;
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
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Double getLongtitude() {
		return longtitude;
	}
	public void setLongtitude(Double longtitude) {
		this.longtitude = longtitude;
	}
	public Double getLatitude() {
		return latitude;
	}
	public void setLatitude(Double latitude) {
		this.latitude = latitude;
	}
	
}
