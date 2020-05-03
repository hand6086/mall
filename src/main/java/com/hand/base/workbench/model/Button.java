package com.hand.base.workbench.model;

import com.hand.base.basic.model.BasicModel;

/**
 * 商品系列
 * @author wangayn
 *
 */
public class Button extends BasicModel{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 6207860006204724368L;
	private String buttonCode;			
	private String buttonName;			
	private String comments;
	private String coverFlag;
	private String imageId;
	private String cityName;
	private String cityId;
	private String headId;
	private String organizationId;
	private String type;
	private String isDisplay;
	private String displayOrder;
	private String source;
	
	public String getButtonCode() {
		return buttonCode;
	}
	public void setButtonCode(String buttonCode) {
		this.buttonCode = buttonCode;
	}
	public String getButtonName() {
		return buttonName;
	}
	public void setButtonName(String buttonName) {
		this.buttonName = buttonName;
	}
	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
	}
	public String getCoverFlag() {
		return coverFlag;
	}
	public void setCoverFlag(String coverFlag) {
		this.coverFlag = coverFlag;
	}
	public String getImageId() {
		return imageId;
	}
	public void setImageId(String imageId) {
		this.imageId = imageId;
	}
	public String getCityName() {
		return cityName;
	}
	public void setCityName(String cityName) {
		this.cityName = cityName;
	}
	public String getCityId() {
		return cityId;
	}
	public void setCityId(String cityId) {
		this.cityId = cityId;
	}
	public String getHeadId() {
		return headId;
	}
	public void setHeadId(String headId) {
		this.headId = headId;
	}
	public String getOrganizationId() {
		return organizationId;
	}
	public void setOrganizationId(String organizationId) {
		this.organizationId = organizationId;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getIsDisplay() {
		return isDisplay;
	}
	public void setIsDisplay(String isDisplay) {
		this.isDisplay = isDisplay;
	}
	public String getDisplayOrder() {
		return displayOrder;
	}
	public void setDisplayOrder(String displayOrder) {
		this.displayOrder = displayOrder;
	}
	public String getSource() {
		return source;
	}
	public void setSource(String source) {
		this.source = source;
	}
	
}
