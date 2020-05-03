package com.hand.base.user.login;

public class HandResult {
	private String pre_token;
	private String empno;
	private String con_status;
	private String status;
	private String returnMsg;
	private String error_code;
	
	public String getPre_token() {
		return pre_token;
	}
	public void setPre_token(String pre_token) {
		this.pre_token = pre_token;
	}
	public String getEmpno() {
		return empno;
	}
	public void setEmpno(String empno) {
		this.empno = empno;
	}
	public String getCon_status() {
		return con_status;
	}
	public void setCon_status(String con_status) {
		this.con_status = con_status;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getReturnMsg() {
		return returnMsg;
	}
	public void setReturnMsg(String returnMsg) {
		this.returnMsg = returnMsg;
	}
	public String getError_code() {
		return error_code;
	}
	public void setError_code(String error_code) {
		this.error_code = error_code;
	}
	
}
