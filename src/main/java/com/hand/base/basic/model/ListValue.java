package com.hand.base.basic.model;

import java.io.Serializable;

/**
 * 接口查询值列表
 * @author ZHENGHONGDA
 *
 */
public class ListValue implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -424286405204628802L;
	
	private String logisticsCompany;			//显示值
	private String logisticsCode;				//独立源代码
	public String getLogisticsCompany() {
		return logisticsCompany;
	}
	public void setLogisticsCompany(String logisticsCompany) {
		this.logisticsCompany = logisticsCompany;
	}
	public String getLogisticsCode() {
		return logisticsCode;
	}
	public void setLogisticsCode(String logisticsCode) {
		this.logisticsCode = logisticsCode;
	}
}
