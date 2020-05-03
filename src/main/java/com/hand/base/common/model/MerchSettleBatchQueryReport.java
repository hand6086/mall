package com.hand.base.common.model;
/*
 * @
 * 
 */
public class MerchSettleBatchQueryReport {
	private String START_DATE; // 开始时间
	private String END_DATE;//结束时间
	private String CITY;//城市
	private String STORE_NUM;//商户编码
	private String STORE_NAME;//商户名称
	private String STORE_PHONE;//商户电话
	private String STORE_ALIPAY;//支付宝账号
	
	private String BANK;//开户银行
	private String ACC_NAME;//开户人
	private String CARD;//银行卡号
	private String TOTAL_AMOUNT;//结算总金额
	private String SETTLE_STATUS;//结算状态
	private String NO_SETTLE_REASON;//未结算愿因
	public String getSTART_DATE() {
		return START_DATE;
	}
	public void setSTART_DATE(String sTART_DATE) {
		START_DATE = sTART_DATE;
	}
	public String getEND_DATE() {
		return END_DATE;
	}
	public void setEND_DATE(String eND_DATE) {
		END_DATE = eND_DATE;
	}
	public String getCITY() {
		return CITY;
	}
	public void setCITY(String cITY) {
		CITY = cITY;
	}
	public String getSTORE_NUM() {
		return STORE_NUM;
	}
	public void setSTORE_NUM(String sTORE_NUM) {
		STORE_NUM = sTORE_NUM;
	}
	public String getSTORE_NAME() {
		return STORE_NAME;
	}
	public void setSTORE_NAME(String sTORE_NAME) {
		STORE_NAME = sTORE_NAME;
	}
	public String getSTORE_PHONE() {
		return STORE_PHONE;
	}
	public void setSTORE_PHONE(String sTORE_PHONE) {
		STORE_PHONE = sTORE_PHONE;
	}
	public String getSTORE_ALIPAY() {
		return STORE_ALIPAY;
	}
	public void setSTORE_ALIPAY(String sTORE_ALIPAY) {
		STORE_ALIPAY = sTORE_ALIPAY;
	}
	public String getBANK() {
		return BANK;
	}
	public void setBANK(String bANK) {
		BANK = bANK;
	}
	public String getACC_NAME() {
		return ACC_NAME;
	}
	public void setACC_NAME(String aCC_NAME) {
		ACC_NAME = aCC_NAME;
	}
	public String getCARD() {
		return CARD;
	}
	public void setCARD(String cARD) {
		CARD = cARD;
	}
	public String getTOTAL_AMOUNT() {
		return TOTAL_AMOUNT;
	}
	public void setTOTAL_AMOUNT(String tOTAL_AMOUNT) {
		TOTAL_AMOUNT = tOTAL_AMOUNT;
	}
	
	public String getNO_SETTLE_REASON() {
		return NO_SETTLE_REASON;
	}
	public void setNO_SETTLE_REASON(String nO_SETTLE_REASON) {
		NO_SETTLE_REASON = nO_SETTLE_REASON;
	}
	public String getSETTLE_STATUS() {
		return SETTLE_STATUS;
	}
	public void setSETTLE_STATUS(String sETTLE_STATUS) {
		SETTLE_STATUS = sETTLE_STATUS;
	}
	
	
	

}
