package com.hand.base.basic.model;

import java.io.Serializable;

public class BasicLog extends BasicModel implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 6808897898877329118L;
	
	private String id;
	
	private String username;
	
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	/**
	 * 请求IP
	 */
	private String exIp;
	
	/**
	 * 操作URL
	 */
	private String exUrl;
	
	/**
	 * 操作参数
	 */
	private String exParams;
	
	/**
	 * 操作描述
	 */
	private String exDes;
	
	/**
	 * 操作模块
	 */
	private String exModel;
	
	/**
	 * 日志说明
	 */
	private String exLog;
	
	/**
	 * 错误日志
	 */
	private String errorLog;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}


	public String getExIp() {
		return exIp;
	}

	public void setExIp(String exIp) {
		this.exIp = exIp;
	}

	public String getExUrl() {
		return exUrl;
	}

	public void setExUrl(String exUrl) {
		this.exUrl = exUrl;
	}

	public String getExParams() {
		return exParams;
	}

	public void setExParams(String exParams) {
		this.exParams = exParams;
	}

	public String getExModel() {
		return exModel;
	}

	public void setExModel(String exModel) {
		this.exModel = exModel;
	}

	public String getExLog() {
		return exLog;
	}

	public void setExLog(String exLog) {
		this.exLog = exLog;
	}

	public String getErrorLog() {
		return errorLog;
	}

	public void setErrorLog(String errorLog) {
		this.errorLog = errorLog;
	}

	public String getExDes() {
		return exDes;
	}

	public void setExDes(String exDes) {
		this.exDes = exDes;
	}
	
	public static boolean isInsertAbled(BasicLog record){
		return true;
	}
	
}
