package com.hand.base.charts.model;

import com.hand.base.basic.model.BasicModel;

public class ChartsResultLine extends BasicModel{

	private String resultKey;          	/*结果key*/
	private String resultType;        	/*结果类型*/
	private String resultValue;       	/*结果值*/
	private String headId;             	/*头行关联字段*/


	public String getResultKey() {
		return resultKey;
	}
	public void setResultKey(String resultKey) {
		this.resultKey = resultKey;
	}

	

	public String getHeadId() {
		return headId;
	}
	public void setHeadId(String headId) {
		this.headId = headId;
	}
	public String getResultType() {
		return resultType;
	}
	public void setResultType(String resultType) {
		this.resultType = resultType;
	}
	public String getResultValue() {
		return resultValue;
	}
	public void setResultValue(String resultValue) {
		this.resultValue = resultValue;
	}



}
