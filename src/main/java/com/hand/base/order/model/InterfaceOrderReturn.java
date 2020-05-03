package com.hand.base.order.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * 
 * @author 接口订单返回值
 *
 */
public class InterfaceOrderReturn implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -5883528503019399189L;
	
	private String returnCode;
	
	private String returnStatus;
	
	private String returnMsg;
	
	private String count;
	
	private List<InterfaceOrder> list = new ArrayList<InterfaceOrder>();

	public List<InterfaceOrder> getList() {
		return list;
	}

	public void setList(List<InterfaceOrder> list) {
		this.list = list;
	}

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

	public String getCount() {
		return count;
	}

	public void setCount(String count) {
		this.count = count;
	}
}
