package com.hand.base.charts.model;

import com.hand.base.basic.model.BasicModel;

public class ChartsResult extends BasicModel{

	private String chartsName;     	/*报表名称*/
	private String chartTable;     	/*最终查询表*/
	private String chartKey; /*报表key*/
	public String getChartsName() {
		return chartsName;
	}
	public void setChartsName(String chartsName) {
		this.chartsName = chartsName;
	}
	public String getChartTable() {
		return chartTable;
	}
	public void setChartTable(String chartTable) {
		this.chartTable = chartTable;
	}
	public String getChartKey() {
		return chartKey;
	}
	public void setChartKey(String chartKey) {
		this.chartKey = chartKey;
	}




}
