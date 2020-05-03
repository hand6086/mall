package com.hand.base.basic.model;

import java.io.Serializable;

/**
 * 页面加载参数
 * 
 * @author ZHENGHONGDA
 *
 */
public class AppContext implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 7847158598923534484L;

	/**
	 * 项目名称
	 */
	private String appName = "Portal";

	/**
	 * 用户姓名
	 */
	private String fstName;

	/**
	 * 项目路径
	 */
	private String ctxPath;

	/**
	 * 用户登录名
	 */
	private String username;

	/**
	 * 企业名称
	 */
	private String storeName;

	/**
	 * 用户角色
	 */
	private String role;

	/**
	 * 系统角色
	 */
	private String systemRole;

	/**
	 * 员工类型
	 */
	private String empType;

	/**
	 * 图片共享地址
	 */
	private String picShareUrl;

	/**
	 * 静态资源url
	 */
	private String staticUrl;

	public String getEmpType() {
		return empType;
	}

	public void setEmpType(String empType) {
		this.empType = empType;
	}

	public String getAppName() {
		return appName;
	}

	public void setAppName(String appName) {
		this.appName = appName;
	}

	public String getCtxPath() {
		return ctxPath;
	}

	public void setCtxPath(String ctxPath) {
		this.ctxPath = ctxPath;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getSystemRole() {
		return systemRole;
	}

	public void setSystemRole(String systemRole) {
		this.systemRole = systemRole;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getStoreName() {
		return storeName;
	}

	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}

	public String getPicShareUrl() {
		return picShareUrl;
	}

	public void setPicShareUrl(String picShareUrl) {
		this.picShareUrl = picShareUrl;
	}

	public String getFstName() {
		return fstName;
	}

	public void setFstName(String fstName) {
		this.fstName = fstName;
	}

	public String getStaticUrl() {
		return staticUrl;
	}

	public void setStaticUrl(String staticUrl) {
		this.staticUrl = staticUrl;
	}

}