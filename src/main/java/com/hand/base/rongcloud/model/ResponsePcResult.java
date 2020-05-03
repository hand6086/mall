package com.hand.base.rongcloud.model;

import io.rong.models.Result;
import io.rong.util.GsonUtil;

public class ResponsePcResult extends Result{
	private String token;
	private String appKey;
	private String name;
	private String portrait;
	
	public  ResponsePcResult(String token,String appKey,String name,String portrait,Integer code, String msg) {
		this.token = token;
		this.appKey = appKey;
		this.name = name;
		this.portrait = portrait;
		this.code = code;
		this.msg = msg;
	}
	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public String getAppKey() {
		return appKey;
	}

	public void setAppKey(String appKey) {
		this.appKey = appKey;
	}

	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getPortrait() {
		return portrait;
	}
	
	public void setPortrait(String portrait) {
		this.portrait = portrait;
	}
	
	@Override
	public String toString() {
		return GsonUtil.toJson(this, ResponsePcResult.class);
	}

}
