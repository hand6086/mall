package com.hand.base.common.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.hand.core.util.UserUtil;

public class PanelDetailReportParam {
	@JsonIgnore
	private String	anonymousFlag;	// 匿名标志--只允许服务端设置值
	private String usercorpid;
	private String DATE_FROM;// 下单时间
	private String DATE_TO;
	private String O2O_CITY; // 城市
	private String STATUS_ZB;// 订单状态
	public String getAnonymousFlag() {
		return anonymousFlag;
	}
	
	public void setAnonymousFlag(String anonymousFlag) {
		this.anonymousFlag = anonymousFlag;
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
	public String getSTATUS_ZB() {
		return STATUS_ZB;
	}
	public void setSTATUS_ZB(String sTATUS_ZB) {
		STATUS_ZB = sTATUS_ZB;
	}
	
	

}
