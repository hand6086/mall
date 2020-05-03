package com.hand.base.goods.model;

import com.hand.base.basic.model.BasicModel;

/**
 * 商品系列
 * 
 * @author wangayn
 *
 */
public class GoodsSeries extends BasicModel {

	private String code; // 编码
	private String name; // 系列名称
	private String status; // 状态
	private String notes; // 备注
	private String picId; // 图片Id
	private String channelType; // 所属频道

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getNotes() {
		return notes;
	}

	public void setNotes(String notes) {
		this.notes = notes;
	}

	public String getPicId() {
		return picId;
	}

	public void setPicId(String picId) {
		this.picId = picId;
	}

	public String getChannelType() {
		return channelType;
	}

	public void setChannelType(String channelType) {
		this.channelType = channelType;
	}

}
