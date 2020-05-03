package com.hand.base.charts.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.hand.base.basic.model.BasicModel;
import com.hand.core.util.UserUtil;

public class ChartsParam extends BasicModel{
	@JsonIgnore
	private String	anonymousFlag;			// 匿名标志--只允许服务端设置值
	private String usercorpid;
	private String chartsName;          	/*报表名称*/
	private String paramKey;        	/*最终查询表*/
	private String paramValue;
	private String chartKey;
	public String getChartsName() {
		return chartsName;
	}
	public void setChartsName(String chartsName) {
		this.chartsName = chartsName;
	}
	
	
	public String getParamKey() {
		return paramKey;
	}
	public void setParamKey(String paramKey) {
		this.paramKey = paramKey;
	}
	public String getParamValue() {
		return paramValue;
	}
	public void setParamValue(String paramValue) {
		this.paramValue = paramValue;
	}

	public String getUsercorpid() {
		if (usercorpid != null && !"".equals(usercorpid)) {
			return usercorpid;
		} else {
			if("Y".equals(this.anonymousFlag) && UserUtil.getUser(null) == null){
				return "100";
			}
			return UserUtil.getUser(null).getCorpid();
		}
	}
	
	public void setUsercorpid(String usercorpid) {
		this.usercorpid = usercorpid;
	}
	public String getChartKey() {
		return chartKey;
	}
	public void setChartKey(String chartKey) {
		this.chartKey = chartKey;
	}


}
