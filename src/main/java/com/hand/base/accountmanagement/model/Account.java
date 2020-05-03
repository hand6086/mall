package com.hand.base.accountmanagement.model;

import java.math.BigDecimal;

import com.hand.base.basic.model.BasicModel;

public class Account extends BasicModel {

	/**
	 * 账户
	 */
	private static final long serialVersionUID = -7885694043657422670L;
	private String enterpriseName; /* 商家名称 */
	private BigDecimal deposit; /* 押金 */
	private BigDecimal servChargeProportion; /* 手续费比例 */
	private BigDecimal noArrivalMoney; /* 未入账金额 */
	private BigDecimal withdrawalsMoney; /* 可提现金额 */
	private BigDecimal applyMoney; /* 申请中金额 */
	private BigDecimal applyServCharge; /* 申请中手续费 */
	private BigDecimal beenWithdrawalsMoney; /* 已提现金额 */
	private BigDecimal totalServiceMoney; /* 手续费总计 */
	private String enterpriseId; /* 企业id */
	private BigDecimal serviceCharge; /* 手续费 */
	private String cardNum;				/*银行卡号*/
	private String accntHolder;			/*开户人*/
	private String bank;   				/*开户行*/
	private String isDefault;  /*是否默认账户*/
	private String bankAcctId;  /*银行账户id*/
	private String merchantAccount; /* 商户账户 */
	
	
	//private String bank; /* 开户银行 */
	private String merchantName; /* 开户人 */

	// 一下字段用于账户明细
	private String enterpId; /* 企业id */
	private String d_bank; /* 开户行 */
	private String fundingDirection; /* 资金往来方向 */
	private String receiptType; /* 单据类型 */
	private String d_serviceCharge; /* 手续费 */
	private BigDecimal arrivedAmount; /* 到账金额 */
	private String moneyType; /* 资金类型 */
	private String d_merchantAccount; /* 商家账户 */
	private String receiptCode; /* 单据编号 */
	private String log; /* 日志 */
	private String status; /* 状态 */
	private String billId; /* 提现对账单号 */
	private String remarks; /* 备注 */

	private String isSelect; /* 是否选择 */
	private String fundsStatus; /* 资金状态 */
	private String number; /* 数量 */
	private String prodName; /* 商品名称 */
	private BigDecimal totalMoney; /* 汇总金额 */
	private String applicantPhone; /* 手机号 */
	private String applicantName; /* 姓名 */
	private String fundsType; /* 资金类型 */
	private String type; /* 平台账号类型*/
	private String sequence; /* 序号*/

	
	
	public String getBankAcctId() {
		return bankAcctId;
	}

	public void setBankAcctId(String bankAcctId) {
		this.bankAcctId = bankAcctId;
	}

	public String getIsDefault() {
		return isDefault;
	}

	public void setIsDefault(String isDefault) {
		this.isDefault = isDefault;
	}

	public String getCardNum() {
		return cardNum;
	}

	public void setCardNum(String cardNum) {
		this.cardNum = cardNum;
	}

	public String getAccntHolder() {
		return accntHolder;
	}

	public void setAccntHolder(String accntHolder) {
		this.accntHolder = accntHolder;
	}

	public String getFundsType() {
		return fundsType;
	}

	public void setFundsType(String fundsType) {
		this.fundsType = fundsType;
	}

	public String getApplicantPhone() {
		return applicantPhone;
	}

	public void setApplicantPhone(String applicantPhone) {
		this.applicantPhone = applicantPhone;
	}

	public String getApplicantName() {
		return applicantName;
	}

	public void setApplicantName(String applicantName) {
		this.applicantName = applicantName;
	}

	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}

	public String getProdName() {
		return prodName;
	}

	public void setProdName(String prodName) {
		this.prodName = prodName;
	}

	public BigDecimal getTotalMoney() {
		if(totalMoney !=null){
			return totalMoney.setScale(2,BigDecimal.ROUND_HALF_UP);
		}else{
			return totalMoney;
		}
	}

	public void setTotalMoney(BigDecimal totalMoney) {
		this.totalMoney = totalMoney;
	}

	public String getIsSelect() {
		return isSelect;
	}

	public void setIsSelect(String isSelect) {
		this.isSelect = isSelect;
	}

	public String getFundsStatus() {
		return fundsStatus;
	}

	public void setFundsStatus(String fundsStatus) {
		this.fundsStatus = fundsStatus;
	}

	public String getEnterpId() {
		return enterpId;
	}

	public void setEnterpId(String enterpId) {
		this.enterpId = enterpId;
	}

	public String getD_bank() {
		return d_bank;
	}

	public void setD_bank(String d_bank) {
		this.d_bank = d_bank;
	}

	public String getFundingDirection() {
		return fundingDirection;
	}

	public void setFundingDirection(String fundingDirection) {
		this.fundingDirection = fundingDirection;
	}

	public String getReceiptType() {
		return receiptType;
	}

	public void setReceiptType(String receiptType) {
		this.receiptType = receiptType;
	}

	public String getD_serviceCharge() {
		return d_serviceCharge;
	}

	public void setD_serviceCharge(String d_serviceCharge) {
		this.d_serviceCharge = d_serviceCharge;
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

	public String getD_merchantAccount() {
		return d_merchantAccount;
	}

	public void setD_merchantAccount(String d_merchantAccount) {
		this.d_merchantAccount = d_merchantAccount;
	}

	public String getReceiptCode() {
		return receiptCode;
	}

	public void setReceiptCode(String receiptCode) {
		this.receiptCode = receiptCode;
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

	public BigDecimal getDeposit() {
		if(deposit !=null){
			return deposit.setScale(2,BigDecimal.ROUND_HALF_UP);
		}else{
			return deposit;
		}
		
	}

	public void setDeposit(BigDecimal deposit) {
		this.deposit = deposit;
	}

	public BigDecimal getNoArrivalMoney() {
		if(noArrivalMoney !=null){
			return noArrivalMoney.setScale(2,BigDecimal.ROUND_HALF_UP);
		}else{
			return noArrivalMoney;
		}
		
	}

	public void setNoArrivalMoney(BigDecimal noArrivalMoney) {
		this.noArrivalMoney = noArrivalMoney;
	}

	public BigDecimal getWithdrawalsMoney() {
		if(withdrawalsMoney !=null){
			return withdrawalsMoney.setScale(2,BigDecimal.ROUND_HALF_UP);
		}else{
			return withdrawalsMoney;
		}
	}

	public void setWithdrawalsMoney(BigDecimal withdrawalsMoney) {
		this.withdrawalsMoney = withdrawalsMoney;
	}

	public BigDecimal getApplyMoney() {
		if(applyMoney !=null){
			return applyMoney.setScale(2,BigDecimal.ROUND_HALF_UP);
		}else{
			return applyMoney;
		}
	}

	public void setApplyMoney(BigDecimal applyMoney) {
		this.applyMoney = applyMoney;
	}

	public BigDecimal getApplyServCharge() {
		if(applyServCharge !=null){
			return applyServCharge.setScale(2,BigDecimal.ROUND_HALF_UP);
		}else{
			return applyServCharge;
		}
	}

	public void setApplyServCharge(BigDecimal applyServCharge) {
		this.applyServCharge = applyServCharge;
	}

	public BigDecimal getBeenWithdrawalsMoney() {
		if(beenWithdrawalsMoney !=null){
			return beenWithdrawalsMoney.setScale(2,BigDecimal.ROUND_HALF_UP);
		}else{
			return beenWithdrawalsMoney;
		}
	}

	public void setBeenWithdrawalsMoney(BigDecimal beenWithdrawalsMoney) {
		this.beenWithdrawalsMoney = beenWithdrawalsMoney;
	}

	public BigDecimal getTotalServiceMoney() {
		if(totalServiceMoney !=null){
			return totalServiceMoney.setScale(2,BigDecimal.ROUND_HALF_UP);
		}else{
			return totalServiceMoney;
		}
	}

	public void setTotalServiceMoney(BigDecimal totalServiceMoney) {
		this.totalServiceMoney = totalServiceMoney;
	}

	public String getEnterpriseId() {
		return enterpriseId;
	}

	public void setEnterpriseId(String enterpriseId) {
		this.enterpriseId = enterpriseId;
	}

	public BigDecimal getServiceCharge() {
		if(serviceCharge !=null){
			return serviceCharge.setScale(2,BigDecimal.ROUND_HALF_UP);
		}else{
			return serviceCharge;
		}
	}

	public void setServiceCharge(BigDecimal serviceCharge) {
		this.serviceCharge = serviceCharge;
	}

	public String getEnterpriseName() {
		return enterpriseName;
	}

	public void setEnterpriseName(String enterpriseName) {
		this.enterpriseName = enterpriseName;
	}

	public BigDecimal getServChargeProportion() {
		return servChargeProportion;
	}

	public void setServChargeProportion(BigDecimal servChargeProportion) {
		this.servChargeProportion = servChargeProportion;
	}

	public String getMerchantAccount() {
		return merchantAccount;
	}

	public void setMerchantAccount(String merchantAccount) {
		this.merchantAccount = merchantAccount;
	}

	public String getBank() {
		return bank;
	}

	public void setBank(String bank) {
		this.bank = bank;
	}

	public String getMerchantName() {
		return merchantName;
	}

	public void setMerchantName(String merchantName) {
		this.merchantName = merchantName;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getSequence() {
		return sequence;
	}

	public void setSequence(String sequence) {
		this.sequence = sequence;
	}

}
