package com.hand.base.workbench.model;

import com.hand.base.basic.model.BasicModel;
import com.hand.core.util.AppConstants;

/**
 * 商品系列
 * @author wangayn
 *
 */
public class Popup extends BasicModel{
	
	private String imageComments;	//说明
	private String objectType;		//弹窗对象
	private String displayFlag;		//是否显示
	private String startTime;		//开始时间
	private String endTime;		    //结束时间
	private String sequence;        //显示顺序
	private String cityId;
	private String imageId;
	private String linePath;
	private String cityName;
	public String getImageComments() {
		return imageComments;
	}
	public void setImageComments(String imageComments) {
		this.imageComments = imageComments;
	}
	public String getObjectType() {
		return objectType;
	}
	public void setObjectType(String objectType) {
		this.objectType = objectType;
	}
	public String getDisplayFlag() {
		return displayFlag;
	}
	public void setDisplayFlag(String displayFlag) {
		this.displayFlag = displayFlag;
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
	public String getSequence() {
		return sequence;
	}
	public void setSequence(String sequence) {
		this.sequence = sequence;
	}
	public String getCityId() {
		return cityId;
	}
	public void setCityId(String cityId) {
		this.cityId = cityId;
	}
	public String getImageId() {
		return imageId;
	}
	public void setImageId(String imageId) {
		this.imageId = imageId;
	}
	public String getLinePath() {
		if (linePath != null && !"".equals(linePath)) {
			return AppConstants.portalSharePicHttpDir+linePath;
		} else {
			return linePath;
		}
	}
	public void setLinePath(String linePath) {
		this.linePath = linePath;
	}
	public String getCityName() {
		return cityName;
	}
	public void setCityName(String cityName) {
		this.cityName = cityName;
	}
	
}
