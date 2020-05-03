package com.hand.base.o2oaccnt.model;

import com.hand.base.basic.model.BasicModel;

public class DealerAccount extends BasicModel {

	private String erpCode; /* EMP编码 */
	private String siebleCode; /* siebel编码 */
	private String acctName; /* 客户名称 */
	private String orgCity; /* 城市大区 */
	private String orgName; /* 销售单位 */
	private String frsType; /* 一级分类 */

	public String getErpCode() {
		return erpCode;
	}

	public void setErpCode(String erpCode) {
		this.erpCode = erpCode;
	}

	public String getSiebleCode() {
		return siebleCode;
	}

	public void setSiebleCode(String siebleCode) {
		this.siebleCode = siebleCode;
	}

	public String getAcctName() {
		return acctName;
	}

	public void setAcctName(String acctName) {
		this.acctName = acctName;
	}

	public String getOrgCity() {
		return orgCity;
	}

	public void setOrgCity(String orgCity) {
		this.orgCity = orgCity;
	}

	public String getOrgName() {
		return orgName;
	}

	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}

	public String getFrsType() {
		return frsType;
	}

	public void setFrsType(String frsType) {
		this.frsType = frsType;
	}

}
