package com.hand.base.workbench.model;

import com.hand.base.basic.model.BasicModel;
import com.hand.core.util.AppConstants;

/**
 * 商品系列
 * @author wangayn
 *
 */
public class Banner extends BasicModel{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -5989769100209516360L;
	private String name;				//名称
	private String targetId;			//编码
	private String tAttr01;				//类型
	private String campaignName;		//活动名称
	private String campaignCode;		//活动编码
	private String merchandiseName;     //商品名称
	private String merchandiseCode;     //商品编码
	private String isDisplay;           //是否显示
	private String sequence;	        //显示顺序
	private String startTime;			//开始时间
	private String endTime;				//结束时间
	private String url;					
	private String merchandiseId;	    
	private String image;       		
	private String cityId;
	private String campaignId;
	private String cityName;
	private String classifyId;
	private String classifyName;
	private String source;
	private String imageUrl;
	private String buttonId;
	private String buttonName;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTargetId() {
		return targetId;
	}
	public void setTargetId(String targetId) {
		this.targetId = targetId;
	}
	public String gettAttr01() {
		return tAttr01;
	}
	public void settAttr01(String tAttr01) {
		this.tAttr01 = tAttr01;
	}
	public String getCampaignName() {
		return campaignName;
	}
	public void setCampaignName(String campaignName) {
		this.campaignName = campaignName;
	}
	public String getCampaignCode() {
		return campaignCode;
	}
	public void setCampaignCode(String campaignCode) {
		this.campaignCode = campaignCode;
	}
	public String getMerchandiseName() {
		return merchandiseName;
	}
	public void setMerchandiseName(String merchandiseName) {
		this.merchandiseName = merchandiseName;
	}
	public String getMerchandiseCode() {
		return merchandiseCode;
	}
	public void setMerchandiseCode(String merchandiseCode) {
		this.merchandiseCode = merchandiseCode;
	}
	public String getIsDisplay() {
		return isDisplay;
	}
	public void setIsDisplay(String isDisplay) {
		this.isDisplay = isDisplay;
	}
	public String getSequence() {
		return sequence;
	}
	public void setSequence(String sequence) {
		this.sequence = sequence;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getMerchandiseId() {
		return merchandiseId;
	}
	public void setMerchandiseId(String merchandiseId) {
		this.merchandiseId = merchandiseId;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getCityId() {
		return cityId;
	}
	public void setCityId(String cityId) {
		this.cityId = cityId;
	}
	public String getCampaignId() {
		return campaignId;
	}
	public void setCampaignId(String campaignId) {
		this.campaignId = campaignId;
	}
	public String getCityName() {
		return cityName;
	}
	public void setCityName(String cityName) {
		this.cityName = cityName;
	}
	public String getClassifyId() {
		return classifyId;
	}
	public void setClassifyId(String classifyId) {
		this.classifyId = classifyId;
	}
	public String getClassifyName() {
		return classifyName;
	}
	public void setClassifyName(String classifyName) {
		this.classifyName = classifyName;
	}
	public String getSource() {
		return source;
	}
	public void setSource(String source) {
		this.source = source;
	}
	public String getImageUrl() {
		if (imageUrl != null && !"".equals(imageUrl)) {
			return AppConstants.portalSharePicHttpDir+imageUrl;
		} else {
			return imageUrl;
		}
	}
	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}
	public String getButtonId() {
		return buttonId;
	}
	public void setButtonId(String buttonId) {
		this.buttonId = buttonId;
	}
	public String getButtonName() {
		return buttonName;
	}
	public void setButtonName(String buttonName) {
		this.buttonName = buttonName;
	}
	
}
