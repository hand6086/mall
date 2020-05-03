package com.hand.base.order.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import com.hand.base.basic.model.ListValue;

/**
 * 
 * @author 物流公司名称返回值
 *
 */
public class LogisticsCompanyReturn implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 6472156068730157081L;
	
	private String returnCode;
	
	private String returnStatus;
	
	private String returnMsg;
	
	private List<ListValue> list = new ArrayList<ListValue>();


	public List<ListValue> getList() {
		return list;
	}

	public void setList(List<ListValue> list) {
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
}
