package com.hand.base.workbench.model;

import com.hand.base.basic.model.BasicModel;
import com.hand.core.util.AppConstants;

/**
 * 优惠券承接页
 * @author wangayn
 *
 */
public class CamCoupon extends BasicModel{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -7927823386973635643L;
	private String couponName;	
	private String couponCode;		
	private String displaySeq;		
	private String status;		
	private String prodName;       
	private String prodCode;	
	private String couponId;	
	private String prodId;		
	private String camId;
	private String picId;
	private String picUrl;
	public String getCouponName() {
		return couponName;
	}
	public void setCouponName(String couponName) {
		this.couponName = couponName;
	}
	public String getCouponCode() {
		return couponCode;
	}
	public void setCouponCode(String couponCode) {
		this.couponCode = couponCode;
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
	public String getCouponId() {
		return couponId;
	}
	public void setCouponId(String couponId) {
		this.couponId = couponId;
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
