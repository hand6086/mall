package com.hand.base.charts.model;

import com.hand.base.basic.model.BasicModel;

/**
 * 平台品牌馆商户数据统计
 * @author lijie
 *
 */

public class PlatformBrandMerchDataStatistics extends BasicModel{
	
	/**
	 * 平台品牌馆商户数据统计
	 */
	private static final long serialVersionUID = 4917617664453068327L;
	
	private String goodsType;//商品类别
	private String merchNumber;//商家数量
	public String getGoodsType() {
		return goodsType;
	}
	public void setGoodsType(String goodsType) {
		this.goodsType = goodsType;
	}
	public String getMerchNumber() {
		return merchNumber;
	}
	public void setMerchNumber(String merchNumber) {
		this.merchNumber = merchNumber;
	}
	
}
