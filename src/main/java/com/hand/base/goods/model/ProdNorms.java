package com.hand.base.goods.model;

import com.hand.base.basic.model.BasicModel;

public class ProdNorms extends BasicModel{

	private String prodNormName;       	/*参数名称*/
	private String prodNormVal;        	/*参数值*/
	private String prodId;             	/*商品ID*/


	public String getProdNormName() {
		return prodNormName;
	}
	public void setProdNormName(String prodNormName) {
		this.prodNormName = prodNormName;
	}

	public String getProdNormVal() {
		return prodNormVal;
	}
	public void setProdNormVal(String prodNormVal) {
		this.prodNormVal = prodNormVal;
	}

	public String getProdId() {
		return prodId;
	}
	public void setProdId(String prodId) {
		this.prodId = prodId;
	}



}
