package com.hand.base.brandpromotion.model;

import com.hand.base.basic.model.BasicModel;
import com.hand.core.util.AppConstants;

public class BrandPromotionSchema extends BasicModel{

	private String schemaName;         	/*方案名称*/
	private String tattr13;            	/*报名开始时间*/
	private String tattr14;            	/*报名结束时间*/
	private String type;               	/*促销形式*/
	private String startDate;          	/*活动开始时间*/
	private String endDate;            	/*活动结束时间*/
	private String brandStatus;        	/*品牌馆方案状态*/
	private String comments;           	/*说明*/
	private String source;             	/*频道类型*/
	private String picId;              	/*图片ID*/
	private String path;               	/*图片路径*/


	public String getSchemaName() {
		return schemaName;
	}
	public void setSchemaName(String schemaName) {
		this.schemaName = schemaName;
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

	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
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

	public String getBrandStatus() {
		return brandStatus;
	}
	public void setBrandStatus(String brandStatus) {
		this.brandStatus = brandStatus;
	}

	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
	}

	public String getPicId() {
		return picId;
	}
	public void setPicId(String picId) {
		this.picId = picId;
	}

	public String getSource() {
		return source;
	}
	public void setSource(String source) {
		this.source = source;
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



}
