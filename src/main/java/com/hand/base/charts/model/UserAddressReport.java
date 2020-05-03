package com.hand.base.charts.model;

import com.hand.base.basic.model.BasicModel;
/**
 *用户地址报表
 * @author Administrator
 *
 */
public class UserAddressReport extends BasicModel {
	private String startTime;//开始时间
	private String endTime;//结束时间
	private String province;//省份
	private String count;
	private String city;
	
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
	public String getProvince() {
		return province;
	}
	public void setProvince(String province) {
		this.province = province;
	}
	public String getCount() {
		return count;
	}
	public void setCount(String count) {
		this.count = count;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	
	
	
}
