package com.hand.base.goods.model;

import com.hand.base.basic.model.BasicModel;

import java.math.BigDecimal;

/**
 * 商品明细
 * 
 * @author zhenghongda
 *
 */
public class ProductDetail extends BasicModel {

	private String productId;

	/**
	 * 商品图片Id
	 */
	private String productPicId;

	/**
	 * 商品图片
	 */
	private String productPic;

	/**
	 * 商品图片类型
	 */
	private String productPicType;

	private String comments;

	private Integer seq;

	public Integer getSeq() {
		return seq;
	}

	public void setSeq(Integer seq) {
		this.seq = seq;
	}

	public String getProductPicId() {
		return productPicId;
	}

	public void setProductPicId(String productPicId) {
		this.productPicId = productPicId;
	}

	public String getProductPicType() {
		return productPicType;
	}

	public void setProductPicType(String productPicType) {
		this.productPicType = productPicType;
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

	public String getProductPic() {
		return productPic;
	}

	public void setProductPic(String productPic) {
		this.productPic = productPic;
	}
}
