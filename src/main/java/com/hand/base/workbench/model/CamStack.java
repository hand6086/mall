package com.hand.base.workbench.model;

import com.hand.base.basic.model.BasicModel;
import com.hand.core.util.AppConstants;

/**
 * 商品系列
 * @author wangayn
 *
 */
public class CamStack extends BasicModel{
	
	private String prodName;	//商品名称
	private String prodCode;	//商品编码
	private String displaySeq;	//显示顺序
	private String status;		//状态
	private String prodId;
	private String camId;
	private String picId;
	private String picUrl;
	public String getProdName() {
		return prodName;
	}
	public void setProdName(String prodName) {
		this.prodName = prodName;
	}
	public String getProdCode() {
		return prodCode;
	}
	public void setProdCode(String prodCode) {
		this.prodCode = prodCode;
	}
	public String getDisplaySeq() {
		return displaySeq;
	}
	public void setDisplaySeq(String displaySeq) {
		this.displaySeq = displaySeq;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getProdId() {
		return prodId;
	}
	public void setProdId(String prodId) {
		this.prodId = prodId;
	}
	public String getCamId() {
		return camId;
	}
	public void setCamId(String camId) {
		this.camId = camId;
	}
	public String getPicId() {
		return picId;
	}
	public void setPicId(String picId) {
		this.picId = picId;
	}		
	public String getPicUrl() {
		if (picUrl != null && !"".equals(picUrl)) {
			return AppConstants.portalSharePicHttpDir+picUrl;
		} else {
			return picUrl;
		}
	}
	public void setPicUrl(String picUrl) {
		this.picUrl = picUrl;
	}
}
