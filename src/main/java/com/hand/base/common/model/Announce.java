package com.hand.base.common.model;

import com.hand.base.basic.model.BasicModel;
import com.hand.core.util.AppConstants;

public class Announce extends BasicModel{
	/** 标题 **/
	private String captions;
	/** 内容 **/
	private String contents;
	/** 有效开始时间 **/
	private String startDate;
	/** 有效结束时间 **/
	private String endDate;
	/** 公告状态 **/
	private String anneStatus;
	/**
	 * 公告状态的值（值列表的独立源代码）
	 * 用于在congtroller层筛选
	 */
	private String anneStatusValue;
	/** 公告类型 **/
	private String anneType;
	/**
	 * 公告类型的值（值列表的独立源代码）
	 * 用于在congtroller层筛选
	 */
	private String anneTypeValue;
	/** 发布对象 **/
	private String anneReader;
	/** 限制营销渠道**/
	private String isLimited;
	/** 发布时间 **/
	private String publishDate;
	/** 营销渠道（组织名称） **/
	private String orgName;
	/** 营销渠道（组织Id） **/
	private String orgId;
	/** 公告图片Id **/
	private String announceImgId;
	/** 公告图片地址 **/
	private String path;
	
	public String getAnneTypeValue() {
		return anneTypeValue;
	}

	public String getAnneStatusValue() {
		return anneStatusValue;
	}

	public void setAnneStatusValue(String anneStatusValue) {
		this.anneStatusValue = anneStatusValue;
	}

	public void setAnneTypeValue(String anneTypeValue) {
		this.anneTypeValue = anneTypeValue;
	}

	public String getCaptions() {
		return captions;
	}

	public void setCaptions(String captions) {
		this.captions = captions;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}
	
	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getAnneStatus() {
		return anneStatus;
	}

	public void setAnneStatus(String anneStatus) {
		this.anneStatus = anneStatus;
	}

	public String getAnneType() {
		return anneType;
	}

	public void setAnneType(String anneType) {
		this.anneType = anneType;
	}

	public String getAnneReader() {
		return anneReader;
	}

	public void setAnneReader(String anneReader) {
		this.anneReader = anneReader;
	}

	public String getIsLimited() {
		return isLimited;
	}

	public void setIsLimited(String isLimited) {
		this.isLimited = isLimited;
	}

	public String getPublishDate() {
		return publishDate;
	}

	public void setPublishDate(String publishDate) {
		this.publishDate = publishDate;
	}

	public String getOrgName() {
		return orgName;
	}

	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}

	public String getOrgId() {
		return orgId;
	}

	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}

	public String getAnnounceImgId() {
		return announceImgId;
	}

	public void setAnnounceImgId(String announceImgId) {
		this.announceImgId = announceImgId;
	}

	public String getPath() {
		if (path != null && !"".equals(path)) {
			return AppConstants.portalSharePicHttpDir + path;
		}
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}
	
}
