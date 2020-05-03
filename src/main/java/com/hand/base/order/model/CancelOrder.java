package com.hand.base.order.model;

import com.hand.base.basic.model.BasicModel;

public class CancelOrder extends BasicModel {
	private String orderNum;// 订单编号 //created创建时间 //id Id
	private String orderCity;// 订单城市
	private String determineCancel;// 是否确认取消
	private String determineTime;// 确认取消时间
	private String alreadyCancel;// 是否已取消
	private String cancelTime;// 实际取消时间
	private String cancelComments;// 说明
	private String operator; // 操作人员

	public String getOrderNum() {
		return orderNum;
	}

	public void setOrderNum(String orderNum) {
		this.orderNum = orderNum;
	}

	public String getOrderCity() {
		return orderCity;
	}

	public void setOrderCity(String orderCity) {
		this.orderCity = orderCity;
	}

	public String getDetermineCancel() {
		return determineCancel;
	}

	public void setDetermineCancel(String determineCancel) {
		this.determineCancel = determineCancel;
	}

	public String getDetermineTime() {
		return determineTime;
	}

	public void setDetermineTime(String determineTime) {
		this.determineTime = determineTime;
	}

	public String getAlreadyCancel() {
		return alreadyCancel;
	}

	public void setAlreadyCancel(String alreadyCancel) {
		this.alreadyCancel = alreadyCancel;
	}

	public String getCancelTime() {
		return cancelTime;
	}

	public void setCancelTime(String cancelTime) {
		this.cancelTime = cancelTime;
	}

	public String getCancelComments() {
		return cancelComments;
	}

	public void setCancelComments(String cancelComments) {
		this.cancelComments = cancelComments;
	}

	public String getOperator() {
		return operator;
	}

	public void setOperator(String operator) {
		this.operator = operator;
	}

}
