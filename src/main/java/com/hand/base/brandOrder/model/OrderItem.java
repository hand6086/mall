package com.hand.base.brandOrder.model;

import java.math.BigDecimal;

import com.hand.base.basic.model.BasicModel;
import com.hand.core.util.AppConstants;

public class OrderItem extends BasicModel {
	/**
	 * 订单行
	 */
	private static final long serialVersionUID = -1459493400875761578L;
	private String   	 merchName;			 /* 商品名字 */
	private String  	 merchCode;			 /* 商品编码 */
	private String  	 productCode;			 /* 商品条形码，69码 */
	private String  	 merchPic;			 /* 商品编码 */
	private BigDecimal   price;               /*报价*/
	private BigDecimal   qty;                 /*数量*/
	private BigDecimal   qtyAftersale;        /*售后数量*/
	private BigDecimal   attrib17;            /*报价总金额*/
	private BigDecimal   pmoPrice;            /*成交价*/
	private BigDecimal   tAttr19;             /*成交价总金额*/
	private String  	 attrib11;            /*是否赠品*/
	private String  	 campId;              /*活动id*/
	private String  	 activityName;		  /*活动名称*/
	private BigDecimal   merchantOfferSum;    /*商品优惠金额*/
	private String  	 couponId;			 /*优惠券ID*/
	private BigDecimal   freight;             /*运费*/
	private String  	 headId;              /*订单id*/
	private String  	 aftersaleId;         /*售后id*/
	
	public String getMerchName() {
		return merchName;
	}
	public void setMerchName(String merchName) {
		this.merchName = merchName;
	}
	public String getMerchCode() {
		return merchCode;
	}
	public void setMerchCode(String merchCode) {
		this.merchCode = merchCode;
	}

	public String getProductCode() {
		return productCode;
	}

	public void setProductCode(String productCode) {
		this.productCode = productCode;
	}

	public String getMerchPic() {
		if (merchPic != null && !"".equals(merchPic)) {
			return AppConstants.portalSharePicHttpDir+merchPic;
		} else {
			return merchPic;
		}
	}
	public void setMerchPic(String merchPic) {
		this.merchPic = merchPic;
	}
	public BigDecimal getPrice() {
		return price;
	}
	public void setPrice(BigDecimal price) {
		this.price = price;
	}
	public BigDecimal getQty() {
		return qty;
	}
	public void setQty(BigDecimal qty) {
		this.qty = qty;
	}
	public BigDecimal getQtyAftersale() {
		return qtyAftersale;
	}
	public void setQtyAftersale(BigDecimal qtyAftersale) {
		this.qtyAftersale = qtyAftersale;
	}
	public BigDecimal getAttrib17() {
		return attrib17;
	}
	public void setAttrib17(BigDecimal attrib17) {
		this.attrib17 = attrib17;
	}
	public BigDecimal getPmoPrice() {
		return pmoPrice;
	}
	public void setPmoPrice(BigDecimal pmoPrice) {
		this.pmoPrice = pmoPrice;
	}
	public BigDecimal gettAttr19() {
		return tAttr19;
	}
	public void settAttr19(BigDecimal tAttr19) {
		this.tAttr19 = tAttr19;
	}
	public String getAttrib11() {
		return attrib11;
	}
	public void setAttrib11(String attrib11) {
		this.attrib11 = attrib11;
	}
	public String getCampId() {
		return campId;
	}
	public void setCampId(String campId) {
		this.campId = campId;
	}
	public String getActivityName() {
		return activityName;
	}
	public void setActivityName(String activityName) {
		this.activityName = activityName;
	}
	public BigDecimal getMerchantOfferSum() {
		return merchantOfferSum;
	}
	public void setMerchantOfferSum(BigDecimal merchantOfferSum) {
		this.merchantOfferSum = merchantOfferSum;
	}
	public String getCouponId() {
		return couponId;
	}
	public void setCouponId(String couponId) {
		this.couponId = couponId;
	}
	public BigDecimal getFreight() {
		return freight;
	}
	public void setFreight(BigDecimal freight) {
		this.freight = freight;
	}
	public String getHeadId() {
		return headId;
	}
	public void setHeadId(String headId) {
		this.headId = headId;
	}
	public String getAftersaleId() {
		return aftersaleId;
	}
	public void setAftersaleId(String aftersaleId) {
		this.aftersaleId = aftersaleId;
	}

}
