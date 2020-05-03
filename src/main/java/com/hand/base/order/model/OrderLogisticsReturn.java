package com.hand.base.order.model;

import java.io.Serializable;

/**
 * 
 * @author 接口订单物流更新返回值
 *
 */
public class OrderLogisticsReturn implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -7142488531466076897L;

	private String returnCode;
	
	private String returnStatus;
	
	private String returnMsg;

	public String getReturnCode() {
		return returnCode;
	}

	public void setReturnCode(String returnCode) {
		this.returnCode = returnCode;
	}

	public String getReturnStatus() {
		return returnStatus;
	}

	public void setReturnStatus(String returnStatus) {
		this.returnStatus = returnStatus;
	}

	public String getReturnMsg() {
		return returnMsg;
	}

	public void setReturnMsg(String returnMsg) {
		this.returnMsg = returnMsg;
	}
}
