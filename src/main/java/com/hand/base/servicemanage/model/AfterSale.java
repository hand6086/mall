package com.hand.base.servicemanage.model;

import java.util.Date;

import com.hand.base.basic.model.BasicModel;
import com.hand.core.util.AppConstants;

public class AfterSale extends BasicModel {
	
	/**
	 * 售后服务
	 */
	private static final long serialVersionUID = -3485664510800852688L;
	private String o2oPayType;// 支付方式 //created下单时间
	private String aftermarketType;//售后类型
	private String orderId;//订单ID
	private String orderNumber;//订单编号
	private String payType;//支付方式
	private String phonenumber;//联系电话
	private String fstName;//创建人
	private Double afterSalesAmount;//销售金额
	private String reason;//原因
	private String instructionManual;//备注说明
	private String documentInformation;//凭证信息
	private String processingStatus;//处理状态
	private String refundResult;//退款结果
	private String notes;//审批意见
	private String path;//图片路径
	private Date approvalTime;//客服受理时间
	private String logisticsCompany;//物流公司
	private String logisticsOddNumber;//物流单号
	private String address; //退货地址
	private String contact; //退货收件人
	private String contPhone; //退货联系电话
	private Date confirmationTime; //客服确认时间
	private String customerId; //消费者Id
	public String getO2oPayType() {
		return o2oPayType;
	}
	public void setO2oPayType(String o2oPayType) {
		this.o2oPayType = o2oPayType;
	}
	public String getAftermarketType() {
		return aftermarketType;
	}
	public void setAftermarketType(String aftermarketType) {
		this.aftermarketType = aftermarketType;
	}
	public String getOrderId() {
		return orderId;
	}
	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	public String getOrderNumber() {
		return orderNumber;
	}
	public void setOrderNumber(String orderNumber) {
		this.orderNumber = orderNumber;
	}
	public String getPayType() {
		return payType;
	}
	public void setPayType(String payType) {
		this.payType = payType;
	}
	public String getPhonenumber() {
		return phonenumber;
	}
	public void setPhonenumber(String phonenumber) {
		this.phonenumber = phonenumber;
	}
	
	public String getFstName() {
		return fstName;
	}
	public void setFstName(String fstName) {
		this.fstName = fstName;
	}
	public Double getAfterSalesAmount() {
		return afterSalesAmount;
	}
	public void setAfterSalesAmount(Double afterSalesAmount) {
		this.afterSalesAmount = afterSalesAmount;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public String getInstructionManual() {
		return instructionManual;
	}
	public void setInstructionManual(String instructionManual) {
		this.instructionManual = instructionManual;
	}
	public String getDocumentInformation() {
		return documentInformation;
	}
	public void setDocumentInformation(String documentInformation) {
		this.documentInformation = documentInformation;
	}
	public String getProcessingStatus() {
		return processingStatus;
	}
	public void setProcessingStatus(String processingStatus) {
		this.processingStatus = processingStatus;
	}
	public String getRefundResult() {
		return refundResult;
	}
	public void setRefundResult(String refundResult) {
		this.refundResult = refundResult;
	}
	public String getNotes() {
		return notes;
	}
	public void setNotes(String notes) {
		this.notes = notes;
	}
	public String getPath() {
		return AppConstants.portalSharePicHttpDir+path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public Date getApprovalTime() {
		return approvalTime;
	}
	public void setApprovalTime(Date approvalTime) {
		this.approvalTime = approvalTime;
	}
	public String getLogisticsCompany() {
		return logisticsCompany;
	}
	public void setLogisticsCompany(String logisticsCompany) {
		this.logisticsCompany = logisticsCompany;
	}
	public String getLogisticsOddNumber() {
		return logisticsOddNumber;
	}
	public void setLogisticsOddNumber(String logisticsOddNumber) {
		this.logisticsOddNumber = logisticsOddNumber;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getContact() {
		return contact;
	}
	public void setContact(String contact) {
		this.contact = contact;
	}
	public String getContPhone() {
		return contPhone;
	}
	public void setContPhone(String contPhone) {
		this.contPhone = contPhone;
	}
	public Date getConfirmationTime() {
		return confirmationTime;
	}
	public void setConfirmationTime(Date confirmationTime) {
		this.confirmationTime = confirmationTime;
	}
	public String getCustomerId() {
		return customerId;
	}
	public void setCustomerId(String customerId) {
		this.customerId = customerId;
	}
}
