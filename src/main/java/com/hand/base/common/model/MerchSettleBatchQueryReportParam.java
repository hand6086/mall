package com.hand.base.common.model;

public class MerchSettleBatchQueryReportParam {
	private String DATE_FROM;//開始时间
	private String DATE_TO;//結束時間
	private String O2O_CITY; // 城市
	private String SETTLE_STATUS; // 结算状态
	
	public String getDATE_FROM() {
		return DATE_FROM;
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
	public String getSETTLE_STATUS() {
		return SETTLE_STATUS;
	}
	public void setSETTLE_STATUS(String sETTLE_STATUS) {
		SETTLE_STATUS = sETTLE_STATUS;
	}



	
	

}
