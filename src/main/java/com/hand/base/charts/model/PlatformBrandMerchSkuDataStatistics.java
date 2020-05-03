package com.hand.base.charts.model;

import com.hand.base.basic.model.BasicModel;

/**
 * 平台品牌馆商户SKU数据统计
 * @author lijie
 *
 */

public class PlatformBrandMerchSkuDataStatistics extends BasicModel{
	
	/**
	 * 平台品牌馆商户SKU数据统计
	 */
	private static final long serialVersionUID = 4917617664453068327L;
	
	private String goodsType;//商品类别
	private String merchName;//商家名称
	private String salesType;//销售状态
	private String typeSku;//分类SKU
	private String sku;//SKU
	public String getGoodsType() {
		return goodsType;
	}
	public void setGoodsType(String goodsType) {
		this.goodsType = goodsType;
	}
	public String getMerchName() {
		return merchName;
	}
	public void setMerchName(String merchName) {
		this.merchName = merchName;
	}
	public String getSalesType() {
		return salesType;
	}
	public void setSalesType(String salesType) {
		this.salesType = salesType;
	}
	public String getTypeSku() {
		return typeSku;
	}
	public void setTypeSku(String typeSku) {
		this.typeSku = typeSku;
	}
	public String getSku() {
		return sku;
	}
	public void setSku(String sku) {
		this.sku = sku;
	}
	
}
