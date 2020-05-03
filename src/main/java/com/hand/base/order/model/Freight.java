package com.hand.base.order.model;

import com.hand.base.basic.model.BasicModel;

public class Freight extends BasicModel {
	
	/**
	 * 运费模板
	 */
	private static final long serialVersionUID = -1834320913429827910L;
	private String cityId;// 快购专用，城市ID
	private String cityName;
	
	private String name;// 模板名称
	private String way;// 计费方式
	private String notes;// 模板说明
	private String commodityScope;// 模板名称
	private String mailArea;// 包邮区域
	private String noMailArea;// 不包邮区域
	
	private String o2oDisplayName;//商品名称
	private String areaName;//省份
	
	private Double firstNumber;//基础配送量
	private String firstFee;//基础配送费
	private Double addNumber;//累计配送量
	private String addFee;//累计配送费
	
	private String[] mailAreaAll;
	private String[] nomailAreaAll;
	private String freightId;
	private String areaId;
	
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getWay() {
		return way;
	}
	public void setWay(String way) {
		this.way = way;
	}
	public String getNotes() {
		return notes;
	}
	public void setNotes(String notes) {
		this.notes = notes;
	}
	public String getCommodityScope() {
		return commodityScope;
	}
	public void setCommodityScope(String commodityScope) {
		this.commodityScope = commodityScope;
	}
	public String getMailArea() {
		return mailArea;
	}
	public void setMailArea(String mailArea) {
		this.mailArea = mailArea;
	}
	public String getNoMailArea() {
		return noMailArea;
	}
	public void setNoMailArea(String noMailArea) {
		this.noMailArea = noMailArea;
	}
	public String getO2oDisplayName() {
		return o2oDisplayName;
	}
	public void setO2oDisplayName(String o2oDisplayName) {
		this.o2oDisplayName = o2oDisplayName;
	}
	public String getAreaName() {
		return areaName;
	}
	public void setAreaName(String areaName) {
		this.areaName = areaName;
	}
	
	
	public Double getFirstNumber() {
		return firstNumber;
	}
	public void setFirstNumber(Double firstNumber) {
		this.firstNumber = firstNumber;
	}

	public String getFirstFee() {
		return firstFee;
	}
	public void setFirstFee(String firstFee) {
		this.firstFee = firstFee;
	}
	public Double getAddNumber() {
		return addNumber;
	}
	public void setAddNumber(Double addNumber) {
		this.addNumber = addNumber;
	}

	public String getAddFee() {
		return addFee;
	}
	public void setAddFee(String addFee) {
		this.addFee = addFee;
	}
	public String[] getMailAreaAll() {
		return mailAreaAll;
	}
	public void setMailAreaAll(String[] mailAreaAll) {
		this.mailAreaAll = mailAreaAll;
	}
	public String[] getNomailAreaAll() {
		return nomailAreaAll;
	}
	public void setNomailAreaAll(String[] nomailAreaAll) {
		this.nomailAreaAll = nomailAreaAll;
	}
	public String getFreightId() {
		return freightId;
	}
	public void setFreightId(String freightId) {
		this.freightId = freightId;
	}
	public String getAreaId() {
		return areaId;
	}
	public void setAreaId(String areaId) {
		this.areaId = areaId;
	}
	
}
