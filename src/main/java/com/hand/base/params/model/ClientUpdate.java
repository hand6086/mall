package com.hand.base.params.model;

import com.hand.base.basic.model.BasicModel;

/**
 * O2O参数设置-客户端更新
 *
 */
public class ClientUpdate extends BasicModel {
	private String deviceType;/* 设备类型 */
	private String tAttr01;/* APP类型 */
	private String versionCode;/* 版本号 */
	private String versionName;/* 版本名称 */
	private String tAttr04;/* 链接地址 */
	private String newVerDescription;/* 新版本描述 */
	private String forceUpdate;/* 是否强制更新 */
	private String updateTime;/* 更新时间 */
	
	public ClientUpdate() {
		super();
	}

	public String getDeviceType() {
		return deviceType;
	}

	public void setDeviceType(String deviceType) {
		this.deviceType = deviceType;
	}

	public String gettAttr01() {
		return tAttr01;
	}

	public void settAttr01(String tAttr01) {
		this.tAttr01 = tAttr01;
	}

	public String getVersionCode() {
		return versionCode;
	}

	public void setVersionCode(String versionCode) {
		this.versionCode = versionCode;
	}

	public String getVersionName() {
		return versionName;
	}

	public void setVersionName(String versionName) {
		this.versionName = versionName;
	}

	public String gettAttr04() {
		return tAttr04;
	}

	public void settAttr04(String tAttr04) {
		this.tAttr04 = tAttr04;
	}

	public String getNewVerDescription() {
		return newVerDescription;
	}

	public void setNewVerDescription(String newVerDescription) {
		this.newVerDescription = newVerDescription;
	}

	public String getForceUpdate() {
		return forceUpdate;
	}

	public void setForceUpdate(String forceUpdate) {
		this.forceUpdate = forceUpdate;
	}

	public String getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}

}
