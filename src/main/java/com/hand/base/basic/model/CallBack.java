package com.hand.base.basic.model;

/**
 * 存储过程参数
 * @author ZHENGHONGDA
 *
 */
public class CallBack extends BasicModel{
	
	private String returnSatus;
	
	private String returnMsg;

	public String getReturnSatus() {
		return returnSatus;
	}

	public void setReturnSatus(String returnSatus) {
		this.returnSatus = returnSatus;
	}

	public String getReturnMsg() {
		return returnMsg;
	}

	public void setReturnMsg(String returnMsg) {
		this.returnMsg = returnMsg;
	}
	
}
