package com.hand.base.common.model;

public class SalesExpressReport {
	private String O2O_CITY; // 城市
	private String ACTIVE_ORDER_CNT;//有效订单数量 待抢单+待签收+待评价+已完成
	private String NOT_TAKE_ORDER_CNT;//未接订单数量，订单状态是“待抢单”
	private String TAKE_ORDER_CNT;//已接订单数量，待签收+待评价+已完成
	private String COOP_TAKE_ORDER_CNT;//合作商抢单，是否兜底不为Y，商户非兜底商
	private String COOP_TAKE_ORDER_AVG_TIME;//合作商抢单-平均接单时长
	private String POCKET_TAKE_ORDER_CNT;//兜底商抢单，是否兜底不为Y，商户是兜底商
	private String POCKET_TAKE_ORDER_AVG_TIME;//千兜底商抢单-平均接单时长数
	private String POCKET_ORDER_CNT;//兜底订单数量，是否兜底为“Y”
	private String POCKET_ORDER_AVG_TIME;//兜底订单-平均接单时长
	private String TO_BE_DISTRIBUT_CNT;//待配送数量（未点击开始配送），订单状态是“待签收”+物流状态是“已接单”
	private String TO_BE_SIGN_CNT;//待签收数量（未录入码），订单状态是“待签收”+物流状态是“配送中”
	private String COMPLETE_CNT;//已配送完成数量（已录入码），订单状态是“待评价”或“已完成”
	private String ORI_PRICE_ORDER_CNT;//原价订单，四种费用都为0
	private String COUPON_ORDER_CNT;//优惠券订单，优惠券金额不为0
	private String SECKILL_ORDER_CNT;//秒杀订单,是否秒杀订单为Y
	private String BUY_GIFT_ORDER_CNT;//买赠订单,买赠金额不为0
	public String getO2O_CITY() {
		return O2O_CITY;
	}
	public void setO2O_CITY(String o2o_CITY) {
		O2O_CITY = o2o_CITY;
	}
	public String getACTIVE_ORDER_CNT() {
		return ACTIVE_ORDER_CNT;
	}
	public void setACTIVE_ORDER_CNT(String aCTIVE_ORDER_CNT) {
		ACTIVE_ORDER_CNT = aCTIVE_ORDER_CNT;
	}
	public String getNOT_TAKE_ORDER_CNT() {
		return NOT_TAKE_ORDER_CNT;
	}
	public void setNOT_TAKE_ORDER_CNT(String nOT_TAKE_ORDER_CNT) {
		NOT_TAKE_ORDER_CNT = nOT_TAKE_ORDER_CNT;
	}
	public String getTAKE_ORDER_CNT() {
		return TAKE_ORDER_CNT;
	}
	public void setTAKE_ORDER_CNT(String tAKE_ORDER_CNT) {
		TAKE_ORDER_CNT = tAKE_ORDER_CNT;
	}
	public String getCOOP_TAKE_ORDER_CNT() {
		return COOP_TAKE_ORDER_CNT;
	}
	public void setCOOP_TAKE_ORDER_CNT(String cOOP_TAKE_ORDER_CNT) {
		COOP_TAKE_ORDER_CNT = cOOP_TAKE_ORDER_CNT;
	}
	public String getCOOP_TAKE_ORDER_AVG_TIME() {
		return COOP_TAKE_ORDER_AVG_TIME;
	}
	public void setCOOP_TAKE_ORDER_AVG_TIME(String cOOP_TAKE_ORDER_AVG_TIME) {
		COOP_TAKE_ORDER_AVG_TIME = cOOP_TAKE_ORDER_AVG_TIME;
	}
	public String getPOCKET_TAKE_ORDER_CNT() {
		return POCKET_TAKE_ORDER_CNT;
	}
	public void setPOCKET_TAKE_ORDER_CNT(String pOCKET_TAKE_ORDER_CNT) {
		POCKET_TAKE_ORDER_CNT = pOCKET_TAKE_ORDER_CNT;
	}
	public String getPOCKET_TAKE_ORDER_AVG_TIME() {
		return POCKET_TAKE_ORDER_AVG_TIME;
	}
	public void setPOCKET_TAKE_ORDER_AVG_TIME(String pOCKET_TAKE_ORDER_AVG_TIME) {
		POCKET_TAKE_ORDER_AVG_TIME = pOCKET_TAKE_ORDER_AVG_TIME;
	}
	public String getPOCKET_ORDER_CNT() {
		return POCKET_ORDER_CNT;
	}
	public void setPOCKET_ORDER_CNT(String pOCKET_ORDER_CNT) {
		POCKET_ORDER_CNT = pOCKET_ORDER_CNT;
	}
	public String getPOCKET_ORDER_AVG_TIME() {
		return POCKET_ORDER_AVG_TIME;
	}
	public void setPOCKET_ORDER_AVG_TIME(String pOCKET_ORDER_AVG_TIME) {
		POCKET_ORDER_AVG_TIME = pOCKET_ORDER_AVG_TIME;
	}
	public String getTO_BE_DISTRIBUT_CNT() {
		return TO_BE_DISTRIBUT_CNT;
	}
	public void setTO_BE_DISTRIBUT_CNT(String tO_BE_DISTRIBUT_CNT) {
		TO_BE_DISTRIBUT_CNT = tO_BE_DISTRIBUT_CNT;
	}
	public String getTO_BE_SIGN_CNT() {
		return TO_BE_SIGN_CNT;
	}
	public void setTO_BE_SIGN_CNT(String tO_BE_SIGN_CNT) {
		TO_BE_SIGN_CNT = tO_BE_SIGN_CNT;
	}
	public String getCOMPLETE_CNT() {
		return COMPLETE_CNT;
	}
	public void setCOMPLETE_CNT(String cOMPLETE_CNT) {
		COMPLETE_CNT = cOMPLETE_CNT;
	}
	public String getORI_PRICE_ORDER_CNT() {
		return ORI_PRICE_ORDER_CNT;
	}
	public void setORI_PRICE_ORDER_CNT(String oRI_PRICE_ORDER_CNT) {
		ORI_PRICE_ORDER_CNT = oRI_PRICE_ORDER_CNT;
	}
	public String getCOUPON_ORDER_CNT() {
		return COUPON_ORDER_CNT;
	}
	public void setCOUPON_ORDER_CNT(String cOUPON_ORDER_CNT) {
		COUPON_ORDER_CNT = cOUPON_ORDER_CNT;
	}
	public String getSECKILL_ORDER_CNT() {
		return SECKILL_ORDER_CNT;
	}
	public void setSECKILL_ORDER_CNT(String sECKILL_ORDER_CNT) {
		SECKILL_ORDER_CNT = sECKILL_ORDER_CNT;
	}
	public String getBUY_GIFT_ORDER_CNT() {
		return BUY_GIFT_ORDER_CNT;
	}
	public void setBUY_GIFT_ORDER_CNT(String bUY_GIFT_ORDER_CNT) {
		BUY_GIFT_ORDER_CNT = bUY_GIFT_ORDER_CNT;
	}
	
	
	
	

	
	

}
