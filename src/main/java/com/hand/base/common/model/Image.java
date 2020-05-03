package com.hand.base.common.model;

import com.hand.base.basic.model.BasicModel;

public class Image extends BasicModel{
	
	private String id;
	private String code;
	private String dbLastUpdSrc;
	private String name;
	private String url;// 相对路径
	private String thumbUrl;//服务器路径
	
	public String getThumbUrl() {
		return thumbUrl;
	}
	public void setThumbUrl(String thumbUrl) {
		this.thumbUrl = thumbUrl;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getDbLastUpdSrc() {
		return dbLastUpdSrc;
	}
	public void setDbLastUpdSrc(String dbLastUpdSrc) {
		this.dbLastUpdSrc = dbLastUpdSrc;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	
	
	
}
