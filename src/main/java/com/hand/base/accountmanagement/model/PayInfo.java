package com.hand.base.accountmanagement.model;

import java.math.BigDecimal;

import com.hand.base.basic.model.BasicModel;

public class PayInfo extends BasicModel {
	private BigDecimal arrivedAmount; /* 金额 */
	private String receiptCode; /* 订单编号 */
	private String fundingDirection; /* 资金往来方向 */
	private String merchantAccount; /* 商户账户 */
	private String isSelect; /* 是否选择 */
	private String billId; /* 对账单号 */
	private String status; /* 资金状态 */
	private String fundsType; /* 资金类型 */
	private String receiptType;/*单据类型*/
	private int number;      		/*数量*/
	private String prodName; /*商品名称*/

	
	
	public int getNumber() {
		return number;
	}

	public void setNumber(int number) {
		this.number = number;
	}

	public String getProdName() {
		return prodName;
	}

	public void setProdName(String prodName) {
		this.prodName = prodName;
	}

	public String getReceiptType() {
		return receiptType;
	}

	public void setReceiptType(String receiptType) {
		this.receiptType = receiptType;
	}

	public BigDecimal getArrivedAmount() {
		if(arrivedAmount !=null){
			return arrivedAmount.setScale(2,BigDecimal.ROUND_HALF_UP);
		}else{
			return arrivedAmount;
		}
	}

	public void setArrivedAmount(BigDecimal arrivedAmount) {
		this.arrivedAmount = arrivedAmount;
	}

	public String getReceiptCode() {
		return receiptCode;
	}

	public void setReceiptCode(String receiptCode) {
		this.receiptCode = receiptCode;
	}

	public String getFundingDirection() {
		return fundingDirection;
	}

	public void setFundingDirection(String fundingDirection) {
		this.fundingDirection = fundingDirection;
	}

	public String getMerchantAccount() {
		return merchantAccount;
	}

	public void setMerchantAccount(String merchantAccount) {
		this.merchantAccount = merchantAccount;
	}

	public String getIsSelect() {
		return isSelect;
	}

	public void setIsSelect(String isSelect) {
		this.isSelect = isSelect;
	}



	public String getBillId() {
		return billId;
	}

	public void setBillId(String billId) {
		this.billId = billId;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getFundsType() {
		return fundsType;
	}

	public void setFundsType(String fundsType) {
		this.fundsType = fundsType;
	}

}
