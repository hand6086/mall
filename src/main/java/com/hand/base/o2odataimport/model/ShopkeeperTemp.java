package com.hand.base.o2odataimport.model;

import com.hand.base.basic.model.BasicModel;

public class ShopkeeperTemp extends BasicModel {
	private String checkStatus;/*
								 * 校验状态picklist:TB Check Status ,Expr:
								 * 'LookupValue("TB_CHECK_STATUS","New")'
								 */
	private String impStatus;/*
								 * 导入状态TB Import Status,Expr:
								 * 'LookupValue("TB_IMPORT_STATUS","New")'
								 */
	private String errMessage;/* 错误信息 */
	private String lastName;/* 姓氏 */
	private String firstName;/* 名字 */
	private String cellPhone;/* 手机号 */
	private String status;/* 状态 */
	private String acctCode;/* 所属客户Siebel编码 */
	private String acctName;/* 所属客户名称 */

	public String getCheckStatus() {
		return checkStatus;
	}

	public void setCheckStatus(String checkStatus) {
		this.checkStatus = checkStatus;
	}

	public String getImpStatus() {
		return impStatus;
	}

	public void setImpStatus(String impStatus) {
		this.impStatus = impStatus;
	}

	public String getErrMessage() {
		return errMessage;
	}

	public void setErrMessage(String errMessage) {
		this.errMessage = errMessage;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getCellPhone() {
		return cellPhone;
	}

	public void setCellPhone(String cellPhone) {
		this.cellPhone = cellPhone;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getAcctCode() {
		return acctCode;
	}

	public void setAcctCode(String acctCode) {
		this.acctCode = acctCode;
	}

	public String getAcctName() {
		return acctName;
	}

	public void setAcctName(String acctName) {
		this.acctName = acctName;
	}

}
