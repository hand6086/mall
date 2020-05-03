package com.hand.base.goods.model;

import com.hand.base.basic.model.BasicModel;
import com.hand.core.util.AppConstants;

import java.math.BigDecimal;

/**
 * 商品
 * 
 * @author zhenghongda
 *
 */
public class Product extends BasicModel {

	/**
	 * 商品ID
	 */
	private String productId;

	/**
	 * 商品名称
	 */
	private String productName;
	/**
	 * 省
	 */
	private String province;
	/**
	 * 市
	 */
	private String city;
	/**
	 * 县
	 */
	private String district;
	/**
	 * 价格
	 */
	private BigDecimal price;

	/**
	 * 描述
	 */
	private String comments;

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getDistrict() {
		return district;
	}

	public void setDistrict(String district) {
		this.district = district;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}

	public String getProductId() {
		return productId;
	}

	public void setProductId(String productId) {
		this.productId = productId;
	}
}
