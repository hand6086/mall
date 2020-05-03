package com.hand.base.o2oaccnt.model;

import com.hand.base.basic.model.BasicModel;

public class Store extends BasicModel{
	private String 	accntCode;	/*客户编码*/
	private String	accntName;	/*客户名称*/
	private String	storeType;	/*商户类型*/
	private String	province;	/*省/直辖市*/
	private String	city;	/*城市*/
	private String	district;	/*区/县*/
	private String	address;	/*详细地址*/
	private String	contact;	/*联系人*/
	private String contactPhone;	/*联系电话*/
	private String	aliPay;	/*支付宝账号*/
	private String	o2oAccntName;/*开户人*/
	private String	bank;	/*开户银行*/
	private String	creaitCard;	/*银行卡号*/
	private String	gpsLong;	/*GPS经度*/
	private String	gpsLati;/*GPS纬度*/
	private String	channelType;	/*渠道类型*/
	private String	forcedStore;	/*是否兜底商户*/
	private String	gpStore;	/*是否团购商户*/
	private String o2oStoreFlag; /*是否O2O商户*/
	private String	status;	/*状态*/
	private String	wareHouse;	/*电商仓库*/
	private String	orderPickStatus;	/*接单状态*/
	private String	cityId ;/*城市id*/
	private String	parentOrgName; /*城市大区*/
	private String	regionOrgName;	/*片区*/
	private String	salesOrgName;	/*销售单位*/
	private String wareHouseId; /*仓库id*/
	private String provinceName;
	private String cityName;
	private String districtName;
	private String empType;
	private String username;
	private String password;
	private String phonenumber;
	
	
	
	
	
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getPhonenumber() {
		return phonenumber;
	}
	public void setPhonenumber(String phonenumber) {
		this.phonenumber = phonenumber;
	}
	public String getO2oStoreFlag() {
		return o2oStoreFlag;
	}
	public void setO2oStoreFlag(String o2oStoreFlag) {
		this.o2oStoreFlag = o2oStoreFlag;
	}
	public String getProvinceName() {
		return provinceName;
	}
	public void setProvinceName(String provinceName) {
		this.provinceName = provinceName;
	}
	public String getCityName() {
		return cityName;
	}
	public void setCityName(String cityName) {
		this.cityName = cityName;
	}
	public String getDistrictName() {
		return districtName;
	}
	public void setDistrictName(String districtName) {
		this.districtName = districtName;
	}
	public String getWareHouseId() {
		return wareHouseId;
	}
	public void setWareHouseId(String wareHouseId) {
		this.wareHouseId = wareHouseId;
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
	public String getStoreType() {
		return storeType;
	}
	public void setStoreType(String storeType) {
		this.storeType = storeType;
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
	public String getContactPhone() {
		return contactPhone;
	}
	public void setContactPhone(String contactPhone) {
		this.contactPhone = contactPhone;
	}
	public String getAliPay() {
		return aliPay;
	}
	public void setAliPay(String aliPay) {
		this.aliPay = aliPay;
	}
	public String getO2oAccntName() {
		return o2oAccntName;
	}
	public void setO2oAccntName(String o2oAccntName) {
		this.o2oAccntName = o2oAccntName;
	}
	public String getBank() {
		return bank;
	}
	public void setBank(String bank) {
		this.bank = bank;
	}
	public String getCreaitCard() {
		return creaitCard;
	}
	public void setCreaitCard(String creaitCard) {
		this.creaitCard = creaitCard;
	}
	public String getGpsLong() {
		return gpsLong;
	}
	public void setGpsLong(String gpsLong) {
		this.gpsLong = gpsLong;
	}
	public String getGpsLati() {
		return gpsLati;
	}
	public void setGpsLati(String gpsLati) {
		this.gpsLati = gpsLati;
	}
	public String getChannelType() {
		return channelType;
	}
	public void setChannelType(String channelType) {
		this.channelType = channelType;
	}
	public String getForcedStore() {
		return forcedStore;
	}
	public void setForcedStore(String forcedStore) {
		this.forcedStore = forcedStore;
	}
	public String getGpStore() {
		return gpStore;
	}
	public void setGpStore(String gpStore) {
		this.gpStore = gpStore;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getWareHouse() {
		return wareHouse;
	}
	public void setWareHouse(String wareHouse) {
		this.wareHouse = wareHouse;
	}
	public String getOrderPickStatus() {
		return orderPickStatus;
	}
	public void setOrderPickStatus(String orderPickStatus) {
		this.orderPickStatus = orderPickStatus;
	}
	public String getCityId() {
		return cityId;
	}
	public void setCityId(String cityId) {
		this.cityId = cityId;
	}
	public String getParentOrgName() {
		return parentOrgName;
	}
	public void setParentOrgName(String parentOrgName) {
		this.parentOrgName = parentOrgName;
	}
	public String getRegionOrgName() {
		return regionOrgName;
	}
	public void setRegionOrgName(String regionOrgName) {
		this.regionOrgName = regionOrgName;
	}
	public String getSalesOrgName() {
		return salesOrgName;
	}
	public void setSalesOrgName(String salesOrgName) {
		this.salesOrgName = salesOrgName;
	}
	public String getEmpType() {
		return empType;
	}
	public void setEmpType(String empType) {
		this.empType = empType;
	}
	
	
}
