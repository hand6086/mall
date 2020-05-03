package com.hand.base.basic.model;

import java.util.Date;

/**
 * 工作流日志
 * @author ZHENGHONGDA
 *
 */
public class JobLog  extends BasicModel {
	
	private Date startDate;
	
	private Date endDate;
	
	private String rType;
	
	private String rNumber;
	
	private String rMessage;
	
	private String headId;

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public String getrType() {
		return rType;
	}

	public void setrType(String rType) {
		this.rType = rType;
	}

	public String getrNumber() {
		return rNumber;
	}

	public void setrNumber(String rNumber) {
		this.rNumber = rNumber;
	}

	public String getrMessage() {
		return rMessage;
	}

	public void setrMessage(String rMessage) {
		this.rMessage = rMessage;
	}

	public String getHeadId() {
		return headId;
	}

	public void setHeadId(String headId) {
		this.headId = headId;
	}
	
}
