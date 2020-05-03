package com.hand.base.common.model;

import com.hand.base.basic.model.BasicModel;

public class Log extends BasicModel {
	
	private String id;
	
	private String typeCd;
	
	private String logLvl;
	
	private String logContent;
	
	private byte[] logContents;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTypeCd() {
		return typeCd;
	}

	public void setTypeCd(String typeCd) {
		this.typeCd = typeCd;
	}

	public String getLogLvl() {
		return logLvl;
	}

	public void setLogLvl(String logLvl) {
		this.logLvl = logLvl;
	}

	public String getLogContent() {
		return logContent;
	}

	public void setLogContent(String logContent) {
		this.logContent = logContent;
	}

	public byte[] getLogContents() {
		return logContents;
	}

	public void setLogContents(byte[] logContents) {
		this.logContents = logContents;
	}
}
