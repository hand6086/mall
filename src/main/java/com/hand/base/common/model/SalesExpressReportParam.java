package com.hand.base.common.model;

public class SalesExpressReportParam {
	
	private String DATE_FROM;//開始时间
	private String DATE_TO;//結束時間
	private String START_HOUR;//開始时间-小时
	private String END_HOUR;//結束時間-小时
	private String O2O_CITY; // 城市
	
	public String getDATE_FROM() {
		return DATE_FROM;
	}
	public String getSTART_HOUR() {
		return START_HOUR;
	}
	public void setSTART_HOUR(String sTART_HOUR) {
		START_HOUR = sTART_HOUR;
	}
	public String getEND_HOUR() {
		return END_HOUR;
	}
	public void setEND_HOUR(String eND_HOUR) {
		END_HOUR = eND_HOUR;
	}
	public void setDATE_FROM(String dATE_FROM) {
		DATE_FROM = dATE_FROM;
	}
	public String getDATE_TO() {
		return DATE_TO;
	}
	public void setDATE_TO(String dATE_TO) {
		DATE_TO = dATE_TO;
	}
	public String getO2O_CITY() {
		return O2O_CITY;
	}
	public void setO2O_CITY(String o2o_CITY) {
		O2O_CITY = o2o_CITY;
	}

	
	

}
