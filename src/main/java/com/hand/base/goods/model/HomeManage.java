package com.hand.base.goods.model;

import com.hand.base.basic.model.BasicModel;

import java.math.BigDecimal;

/**
 * 首页管理
 * 
 * @author zhenghongda
 *
 */
public class HomeManage extends BasicModel {

	/**
	 * 类型
	 */
	private String type;

	/**
	 * 图片id
	 */
	private String picId;
	/**
	 * 图片地址
	 */
	private String pic;

	private String comments;

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getPicId() {
		return picId;
	}

	public void setPicId(String picId) {
		this.picId = picId;
	}

	public String getPic() {
		return pic;
	}

	public void setPic(String pic) {
		this.pic = pic;
	}
}
