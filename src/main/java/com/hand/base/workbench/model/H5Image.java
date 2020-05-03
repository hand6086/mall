package com.hand.base.workbench.model;

import com.hand.base.basic.model.BasicModel;

/**
 * 短信发送-号码导入
 * @author wangyan
 *
 */
public class H5Image  extends BasicModel{
	
	private String imgCode;			
	private String type;	
	private String comments;			
	private String h5Title;
	private String h5Text;			
	private String imgName;
	private String imgId;
	public String getImgCode() {
		return imgCode;
	}
	public void setImgCode(String imgCode) {
		this.imgCode = imgCode;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
	}
	public String getH5Title() {
		return h5Title;
	}
	public void setH5Title(String h5Title) {
		this.h5Title = h5Title;
	}
	public String getH5Text() {
		return h5Text;
	}
	public void setH5Text(String h5Text) {
		this.h5Text = h5Text;
	}
	public String getImgName() {
		return imgName;
	}
	public void setImgName(String imgName) {
		this.imgName = imgName;
	}
	public String getImgId() {
		return imgId;
	}
	public void setImgId(String imgId) {
		this.imgId = imgId;
	}
	
	
}
