package com.hand.base.charts.model;

import com.hand.base.basic.model.BasicModel;

/**
 * 页面统计分析      活动浏览量分析      商品浏览量分析      商家浏览量分析
 * @author lijie
 *
 */

public class ChartsBrowsingAnalysis extends BasicModel{
	
	/**
	 * 页面统计分析      活动浏览量分析      商品浏览量分析      商家浏览量分析
	 */
	private static final long serialVersionUID = 4917617664453068327L;
	private String startTime;//开始时间
	private String endTime;//结束时间
	private String province;//省份
	private String city;//城市名称
	private String pV;//不去重次数
	private String uV;//去重复次数
	private String merchName;//商家名称
	private String brandBusinessName;//品牌商名称
	private String code;//商品code
	private String goodsName;//商品名称
	private String activityName;//活动名称
	private String pageName;//页面名称
	private String chooseType;//选择类型--快购or品牌馆
	
	public String getBrandBusinessName() {
		return brandBusinessName;
	}
	public void setBrandBusinessName(String brandBusinessName) {
		this.brandBusinessName = brandBusinessName;
	}
	public String getChooseType() {
		return chooseType;
	}
	public void setChooseType(String chooseType) {
		this.chooseType = chooseType;
	}
	public String getMerchName() {
		return merchName;
	}
	public void setMerchName(String merchName) {
		this.merchName = merchName;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getGoodsName() {
		return goodsName;
	}
	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}
	public String getActivityName() {
		return activityName;
	}
	public void setActivityName(String activityName) {
		this.activityName = activityName;
	}
	public String getPageName() {
		return pageName;
	}
	public void setPageName(String pageName) {
		this.pageName = pageName;
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
