package com.hand.base.charts.model;

import com.hand.base.basic.model.BasicModel;

public class OperatingSystemReport extends BasicModel{
	private String startTime;//开始时间
	private String endTime;//结束时间
	private String count;//数量
	private String name;
	private String PhoneNumber;
	private String loginTime;//登陆时间
	private String userId;//
	private String cityId;
	private String cityName;
	private String cityType;
	private String parentCityId;
	private String parentCityName;
	private String parentCityType;
	private String loginSystem;//登陆系统
	private String deviceNum;//设备编号
	private String phoneType;//手机类型
	private String systemVercion;//系统版本
	
	
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhoneNumber() {
		return PhoneNumber;
	}
	public void setPhoneNumber(String phoneNumber) {
		PhoneNumber = phoneNumber;
	}
	public String getLoginTime() {
		return loginTime;
	}
	public void setLoginTime(String loginTime) {
		this.loginTime = loginTime;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getCityId() {
		return cityId;
	}
	public void setCityId(String cityId) {
		this.cityId = cityId;
	}
	public String getCityName() {
		return cityName;
	}
	public void setCityName(String cityName) {
		this.cityName = cityName;
	}
	public String getCityType() {
		return cityType;
	}
	public void setCityType(String cityType) {
		this.cityType = cityType;
	}
	public String getParentCityId() {
		return parentCityId;
	}
	public void setParentCityId(String parentCityId) {
		this.parentCityId = parentCityId;
	}
	public String getParentCityName() {
		return parentCityName;
	}
	public void setParentCityName(String parentCityName) {
		this.parentCityName = parentCityName;
	}
	public String getParentCityType() {
		return parentCityType;
	}
	public void setParentCityType(String parentCityType) {
		this.parentCityType = parentCityType;
	}
	public String getLoginSystem() {
		return loginSystem;
	}
	public void setLoginSystem(String loginSystem) {
		this.loginSystem = loginSystem;
	}
	public String getDeviceNum() {
		return deviceNum;
	}
	public void setDeviceNum(String deviceNum) {
		this.deviceNum = deviceNum;
	}
	public String getPhoneType() {
		return phoneType;
	}
	public void setPhoneType(String phoneType) {
		this.phoneType = phoneType;
	}
	public String getSystemVercion() {
		return systemVercion;
	}
	public void setSystemVercion(String systemVercion) {
		this.systemVercion = systemVercion;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public String getCount() {
		return count;
	}
	public void setCount(String count) {
		this.count = count;
	}
	
	
}
