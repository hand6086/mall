package com.hand.base.charts.model;

import com.hand.base.basic.model.BasicModel;

/**
 * 平台活跃度
 * @author lijie
 *
 */

public class PlatformDailyActivity extends BasicModel{
	
	/**
	 * 平台活跃度
	 */
	private static final long serialVersionUID = 4917617664453068327L;
	private String startTime;//开始时间
	private String endTime;//结束时间
	private String province;//省份
	private String city;//城市名称
	private String pV;//用户登录频次
	private String uV;//去重登录频次
	
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
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getpV() {
		return pV;
	}
	public void setpV(String pV) {
		this.pV = pV;
	}
	public String getuV() {
		return uV;
	}
	public void setuV(String uV) {
		this.uV = uV;
	}
}
