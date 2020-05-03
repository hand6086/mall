package com.hand.base.accountmanagement.model;

import java.math.BigDecimal;

import com.hand.base.basic.model.BasicModel;

public class BillInfo extends BasicModel {
	private String enterpId; /* 企业id */
	private String bank; /* 开户行 */
	private String fundingDirection; /* 资金往来方向 */
	private String receiptCode; /* 单据编号 */
	private String receiptType; /* 单据类型 */
	private BigDecimal serviceCharge; /* 手续费 */
	private BigDecimal arrivedAmount; /* 到账金额 */
	private BigDecimal servChargeProportion;	 /*手续费比例*/
	private String moneyType; /* 资金类型 */
	private String merchantAccount; /* 商家账户 */
	private String log; /* 日志 */
	private String status; /* 状态 */
	private String billId; /* 提现对账单号 */
	private String remarks; /* 备注 */
	private String entpName;            /*企业名称*/
	private String phone;               /*绑定手机*/
	private String approvalOpinion;	 /*审批意见*/

	
	
	public BigDecimal getServChargeProportion() {
		return servChargeProportion;
	}

	public void setServChargeProportion(BigDecimal servChargeProportion) {
		this.servChargeProportion = servChargeProportion;
	}

	public String getEntpName() {
		return entpName;
	}

	public void setEntpName(String entpName) {
		this.entpName = entpName;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getApprovalOpinion() {
		return approvalOpinion;
	}

	public void setApprovalOpinion(String approvalOpinion) {
		this.approvalOpinion = approvalOpinion;
	}

	public String getEnterpId() {
		return enterpId;
	}

	public void setEnterpId(String enterpId) {
		this.enterpId = enterpId;
	}

	public String getBank() {
		return bank;
	}

	public void setBank(String bank) {
		this.bank = bank;
	}

	public String getFundingDirection() {
		return fundingDirection;
	}

	public void setFundingDirection(String fundingDirection) {
		this.fundingDirection = fundingDirection;
	}

	public String getReceiptCode() {
		return receiptCode;
	}

	public void setReceiptCode(String receiptCode) {
		this.receiptCode = receiptCode;
	}

	public String getReceiptType() {
		return receiptType;
	}

	public void setReceiptType(String receiptType) {
		this.receiptType = receiptType;
	}

	public BigDecimal getServiceCharge() {
		if(serviceCharge !=null){
			return serviceCharge.setScale(2,BigDecimal.ROUND_HALF_UP);
		}else{
			return serviceCharge;
		}
	}

	public void setServiceCharge(BigDecimal applySerCharge) {
		this.serviceCharge = applySerCharge;
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

	public String getMoneyType() {
		return moneyType;
	}

	public void setMoneyType(String moneyType) {
		this.moneyType = moneyType;
	}

	public String getMerchantAccount() {
		return merchantAccount;
	}

	public void setMerchantAccount(String merchantAccount) {
		this.merchantAccount = merchantAccount;
	}

	public String getLog() {
		return log;
	}

	public void setLog(String log) {
		this.log = log;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}



	public String getBillId() {
		return billId;
	}

	public void setBillId(String billId) {
		this.billId = billId;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

}
