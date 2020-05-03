package com.hand.base.promotion.model;

import com.hand.base.basic.model.BasicModel;
import com.hand.core.util.AppConstants;

public class SalesPromotionSchema extends BasicModel {

	private static final long serialVersionUID = 5675632146789988450L;

	/**
	 * 促销方案名称
	 */
	private String schemaName;

	/**
	 * 开始时间
	 */
	private String startDate;

	/**
	 * 结束时间
	 */
	private String endDate;

	/**
	 * 大区
	 */
	private String city;

	/**
	 * 大区
	 */
	private String cityId;

	/**
	 * 默认商品
	 */
	private String defaultProduct;

	/**
	 * 方案状态
	 */
	private String status;

	/**
	 * 促销形式
	 */
	private String type;

	/**
	 * 活动自动审批
	 */
	private String approvalFlg;

	/**
	 * 说明
	 */
	private String comments;

	/**
	 * 审批界面 常规界面标志
	 */
	private String isApproved;

	/**
	 * 创建人
	 */
	private String createdName;

	/**
	 * 页面是否删除标识
	 */
	private String deleteFlg;

	private String tattr13; /* 报名开始时间 */
	private String tattr14; /* 报名结束时间 */
	private String brandStatus; /* 品牌馆方案状态 */
	private String source; /* 频道类型 */
	private String picId; /* 图片ID */
	private String path; /* 图片路径 */

	public String getSchemaName() {
		return schemaName;
	}

	public void setSchemaName(String schemaName) {
		this.schemaName = schemaName;
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

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getCityId() {
		return cityId;
	}

	public void setCityId(String cityId) {
		this.cityId = cityId;
	}

	public String getDefaultProduct() {
		return defaultProduct;
	}

	public void setDefaultProduct(String defaultProduct) {
		this.defaultProduct = defaultProduct;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getApprovalFlg() {
		return approvalFlg;
	}

	public void setApprovalFlg(String approvalFlg) {
		this.approvalFlg = approvalFlg;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}

	public String getIsApproved() {
		return isApproved;
	}

	public void setIsApproved(String isApproved) {
		this.isApproved = isApproved;
	}

	public String getCreatedName() {
		return createdName;
	}

	public void setCreatedName(String createdName) {
		this.createdName = createdName;
	}

	public String getTattr13() {
		return tattr13;
	}

	public void setTattr13(String tattr13) {
		this.tattr13 = tattr13;
	}

	public String getTattr14() {
		return tattr14;
	}

	public void setTattr14(String tattr14) {
		this.tattr14 = tattr14;
	}

	public String getBrandStatus() {
		return brandStatus;
	}

	public void setBrandStatus(String brandStatus) {
		this.brandStatus = brandStatus;
	}

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}

	public String getPicId() {
		return picId;
	}

	public void setPicId(String picId) {
		this.picId = picId;
	}

	public String getPath() {
		if (path != null && !"".equals(path)) {
			return AppConstants.portalSharePicHttpDir + path;
		}
		return AppConstants.portalStaticUrl + "/static/images/404.jpg";
	}

	public void setPath(String path) {
		this.path = path;
	}

	public String getDeleteFlg() {
		return deleteFlg;
	}

	public void setDeleteFlg(String deleteFlg) {
		this.deleteFlg = deleteFlg;
	}

}