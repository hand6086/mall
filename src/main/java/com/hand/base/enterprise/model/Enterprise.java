package com.hand.base.enterprise.model;

import java.math.BigDecimal;

import com.hand.base.basic.model.BasicModel;
import com.hand.core.util.AppConstants;

public class Enterprise extends BasicModel {

	/**
	 * 
	 */
	private static final long serialVersionUID = -9207789001141007013L;
	private String corpId;
	private String name; /* 名称 */
	private String comments; /* 说明 */

	private String userId; /* 用户ID */
	private String code; /* 编号 */

	private String brandAuthorizaStart;
	private String brandAuthorizaEnd;
	private String storeDetails;
	private String markRegistrationNum;
	private String applicantName;
	private String applicantMailbox;
	private String applicantPhone;
	private String ifThirdStore;
	private String companyName;
	private String province;
	private String companyAddress;
	private String cLegalPersonMail;
	private String cLegalPersonPhone;
	private String cLegalPersonIDNum;
	private String BusinessLicenseNum;
	private String organizatioCode;
	private String TaxIdentifiCode;
	private String socialCreditCode;
	private String auditStatus;
	private String county;
	private String city;

	private String storeName;
	private String mainProductCategory;
	private String businessLicenseNum;
	private String taxIdentifiCode;
	private String iDStarttime;
	private String iDFinishtime;
	private String ifDomEnterProve;
	private String emergenContactPhone;
	private String ifThreeInOne;
	private String pIdentifiCard;
	private String nIdtifiCard;
	private String businessLicense;
	private String openAccountLicense;
	private String qualityReport;
	private String certificateRegistration;
	private String authorizationCertificate;
	private String storeLogo;
	private String pIdentifiCardPath;
	private String nIdtifiCardPath;
	private String businessLicensePath;
	private String openAccountLicensePath;
	private String qualityReportPath;
	private String certificateRegistrationPath;
	private String authorizationCertificatePath;
	private String storeLogoPath;
	private String approvalOpinion;// 审批意见

	/* 押金详情界面用到的字段 */
	private String depositId;/* 押金id */
	private String sourceCode;/* 来源编码 */
	private String sourceType;/* 来源方式 */
	private BigDecimal money;/* 金额 */
	private String paymentTime;/* 转账时间 */
	private String remarks; /* 备注 */
	private String entpId;/* 企业id */

	private String storeAddress; /* 网店收货地址 */
	private String sales; /* 销售额 */
	private String salesNum; /* 销量 */
	private String depositPayable; /* 应付店铺押金 */
	private String depositPaid; /* 已付店铺押金 */
	private String activityDeposit; /* 已付活动押金 */
	private String totalDeposit; /* 押金合计 */

	private String custName; /* 客服姓名 */
	private String nickname;/* 客服昵称 */
	private String custCode;/* 客服编码 */
	private String custPhone;/* 客服电话 */
	private String custSstatus;/* 客服状态 */
	private String transferCode;/* 转账验证码 */
	private String enterpriseStatus;/* 企业状态 */
	private String storeType;/* 店铺类型 */
	private BigDecimal servChargePro;/* 手续费比例 */
	private String password;/*密码*/
	private String crmDutyId;/*密码*/
	private String storeStatus;/*商户审批状态*/
	private String storeNumber;/*店铺编号*/
	
	public String getCrmDutyId() {
		return crmDutyId;
	}

	public void setCrmDutyId(String crmDutyId) {
		this.crmDutyId = crmDutyId;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public BigDecimal getServChargePro() {
		return servChargePro;
	}

	public void setServChargePro(BigDecimal servChargePro) {
		this.servChargePro = servChargePro;
	}

	public String getStoreType() {
		return storeType;
	}

	public void setStoreType(String storeType) {
		this.storeType = storeType;
	}

	public String getEnterpriseStatus() {
		return enterpriseStatus;
	}

	public void setEnterpriseStatus(String enterpriseStatus) {
		this.enterpriseStatus = enterpriseStatus;
	}

	public String getTransferCode() {
		return transferCode;
	}

	public void setTransferCode(String transferCode) {
		this.transferCode = transferCode;
	}

	public String getApprovalOpinion() {
		return approvalOpinion;
	}

	public void setApprovalOpinion(String approvalOpinion) {
		this.approvalOpinion = approvalOpinion;
	}

	public String getCustName() {
		return custName;
	}

	public void setCustName(String custName) {
		this.custName = custName;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getCustCode() {
		return custCode;
	}

	public void setCustCode(String custCode) {
		this.custCode = custCode;
	}

	public String getCustPhone() {
		return custPhone;
	}

	public void setCustPhone(String custPhone) {
		this.custPhone = custPhone;
	}

	public String getCustSstatus() {
		return custSstatus;
	}

	public void setCustSstatus(String custSstatus) {
		this.custSstatus = custSstatus;
	}

	public String getStoreAddress() {
		return storeAddress;
	}

	public void setStoreAddress(String storeAddress) {
		this.storeAddress = storeAddress;
	}

	public String getSales() {
		return sales;
	}

	public void setSales(String sales) {
		this.sales = sales;
	}

	public String getSalesNum() {
		return salesNum;
	}

	public void setSalesNum(String salesNum) {
		this.salesNum = salesNum;
	}

	public String getDepositPayable() {
		return depositPayable;
	}

	public void setDepositPayable(String depositPayable) {
		this.depositPayable = depositPayable;
	}

	public String getDepositPaid() {
		return depositPaid;
	}

	public void setDepositPaid(String depositPaid) {
		this.depositPaid = depositPaid;
	}

	public String getActivityDeposit() {
		return activityDeposit;
	}

	public void setActivityDeposit(String activityDeposit) {
		this.activityDeposit = activityDeposit;
	}

	public String getTotalDeposit() {
		return totalDeposit;
	}

	public void setTotalDeposit(String totalDeposit) {
		this.totalDeposit = totalDeposit;
	}

	public String getDepositId() {
		return depositId;
	}

	public void setDepositId(String depositId) {
		this.depositId = depositId;
	}

	public String getSourceCode() {
		return sourceCode;
	}

	public void setSourceCode(String sourceCode) {
		this.sourceCode = sourceCode;
	}

	public String getSourceType() {
		return sourceType;
	}

	public void setSourceType(String sourceType) {
		this.sourceType = sourceType;
	}

	public BigDecimal getMoney() {
		return money;
	}

	public void setMoney(BigDecimal money) {
		this.money = money;
	}

	public String getPaymentTime() {
		return paymentTime;
	}

	public void setPaymentTime(String paymentTime) {
		this.paymentTime = paymentTime;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getEntpId() {
		return entpId;
	}

	public void setEntpId(String entpId) {
		this.entpId = entpId;
	}

	public String getStoreName() {
		return storeName;
	}

	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}

	public String getMainProductCategory() {
		return mainProductCategory;
	}

	public void setMainProductCategory(String mainProductCategory) {
		this.mainProductCategory = mainProductCategory;
	}

	public String getiDStarttime() {
		return iDStarttime;
	}

	public void setiDStarttime(String iDStarttime) {
		this.iDStarttime = iDStarttime;
	}

	public String getiDFinishtime() {
		return iDFinishtime;
	}

	public void setiDFinishtime(String iDFinishtime) {
		this.iDFinishtime = iDFinishtime;
	}

	public String getIfDomEnterProve() {
		return ifDomEnterProve;
	}

	public void setIfDomEnterProve(String ifDomEnterProve) {
		this.ifDomEnterProve = ifDomEnterProve;
	}

	public String getEmergenContactPhone() {
		return emergenContactPhone;
	}

	public void setEmergenContactPhone(String emergenContactPhone) {
		this.emergenContactPhone = emergenContactPhone;
	}

	public String getIfThreeInOne() {
		return ifThreeInOne;
	}

	public void setIfThreeInOne(String ifThreeInOne) {
		this.ifThreeInOne = ifThreeInOne;
	}

	public String getpIdentifiCard() {
		return pIdentifiCard;
	}

	public void setpIdentifiCard(String pIdentifiCard) {
		this.pIdentifiCard = pIdentifiCard;
	}

	public String getnIdtifiCard() {
		return nIdtifiCard;
	}

	public void setnIdtifiCard(String nIdtifiCard) {
		this.nIdtifiCard = nIdtifiCard;
	}

	public String getBusinessLicense() {
		return businessLicense;
	}

	public void setBusinessLicense(String businessLicense) {
		this.businessLicense = businessLicense;
	}

	public String getOpenAccountLicense() {
		return openAccountLicense;
	}

	public void setOpenAccountLicense(String openAccountLicense) {
		this.openAccountLicense = openAccountLicense;
	}

	public String getQualityReport() {
		return qualityReport;
	}

	public void setQualityReport(String qualityReport) {
		this.qualityReport = qualityReport;
	}

	public String getCertificateRegistration() {
		return certificateRegistration;
	}

	public void setCertificateRegistration(String certificateRegistration) {
		this.certificateRegistration = certificateRegistration;
	}

	public String getAuthorizationCertificate() {
		return authorizationCertificate;
	}

	public void setAuthorizationCertificate(String authorizationCertificate) {
		this.authorizationCertificate = authorizationCertificate;
	}

	public String getStoreLogo() {
		return storeLogo;
	}

	public void setStoreLogo(String storeLogo) {
		this.storeLogo = storeLogo;
	}

	public String getBrandAuthorizaStart() {
		return brandAuthorizaStart;
	}

	public void setBrandAuthorizaStart(String brandAuthorizaStart) {
		this.brandAuthorizaStart = brandAuthorizaStart;
	}

	public String getBrandAuthorizaEnd() {
		return brandAuthorizaEnd;
	}

	public void setBrandAuthorizaEnd(String brandAuthorizaEnd) {
		this.brandAuthorizaEnd = brandAuthorizaEnd;
	}

	public String getStoreDetails() {
		return storeDetails;
	}

	public void setStoreDetails(String storeDetails) {
		this.storeDetails = storeDetails;
	}

	public String getMarkRegistrationNum() {
		return markRegistrationNum;
	}

	public void setMarkRegistrationNum(String markRegistrationNum) {
		this.markRegistrationNum = markRegistrationNum;
	}

	public String getApplicantName() {
		return applicantName;
	}

	public void setApplicantName(String applicantName) {
		this.applicantName = applicantName;
	}

	public String getApplicantMailbox() {
		return applicantMailbox;
	}

	public void setApplicantMailbox(String applicantMailbox) {
		this.applicantMailbox = applicantMailbox;
	}

	public String getApplicantPhone() {
		return applicantPhone;
	}

	public void setApplicantPhone(String applicantPhone) {
		this.applicantPhone = applicantPhone;
	}

	public String getIfThirdStore() {
		return ifThirdStore;
	}

	public void setIfThirdStore(String ifThirdStore) {
		this.ifThirdStore = ifThirdStore;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public String getCompanyAddress() {
		return companyAddress;
	}

	public void setCompanyAddress(String companyAddress) {
		this.companyAddress = companyAddress;
	}

	public String getcLegalPersonMail() {
		return cLegalPersonMail;
	}

	public void setcLegalPersonMail(String cLegalPersonMail) {
		this.cLegalPersonMail = cLegalPersonMail;
	}

	public String getcLegalPersonPhone() {
		return cLegalPersonPhone;
	}

	public void setcLegalPersonPhone(String cLegalPersonPhone) {
		this.cLegalPersonPhone = cLegalPersonPhone;
	}

	public String getcLegalPersonIDNum() {
		return cLegalPersonIDNum;
	}

	public void setcLegalPersonIDNum(String cLegalPersonIDNum) {
		this.cLegalPersonIDNum = cLegalPersonIDNum;
	}

	public String getBusinessLicenseNum() {
		return BusinessLicenseNum;
	}

	public void setBusinessLicenseNum(String businessLicenseNum) {
		BusinessLicenseNum = businessLicenseNum;
	}

	public String getOrganizatioCode() {
		return organizatioCode;
	}

	public void setOrganizatioCode(String organizatioCode) {
		this.organizatioCode = organizatioCode;
	}

	public String getTaxIdentifiCode() {
		return TaxIdentifiCode;
	}

	public void setTaxIdentifiCode(String taxIdentifiCode) {
		TaxIdentifiCode = taxIdentifiCode;
	}

	public String getSocialCreditCode() {
		return socialCreditCode;
	}

	public void setSocialCreditCode(String socialCreditCode) {
		this.socialCreditCode = socialCreditCode;
	}

	public String getAuditStatus() {
		return auditStatus;
	}

	public void setAuditStatus(String auditStatus) {
		this.auditStatus = auditStatus;
	}

	public String getCounty() {
		return county;
	}

	public void setCounty(String county) {
		this.county = county;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	private String homePage; /* 企业CRM首页 */

	public String getCorpId() {
		return corpId;
	}

	public void setCorpId(String corpId) {
		this.corpId = corpId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getHomePage() {
		return homePage;
	}

	public void setHomePage(String homePage) {
		this.homePage = homePage;
	}

	public String getStoreStatus() {
		return storeStatus;
	}

	public void setStoreStatus(String storeStatus) {
		this.storeStatus = storeStatus;
	}

	public String getpIdentifiCardPath() {
		if( pIdentifiCardPath != null && !"".equals(pIdentifiCardPath) ){
			return AppConstants.portalSharePicHttpDir + pIdentifiCardPath;
		}
		return pIdentifiCardPath;
	}

	public void setpIdentifiCardPath(String pIdentifiCardPath) {
		this.pIdentifiCardPath = pIdentifiCardPath;
	}

	public String getnIdtifiCardPath() {
		if( nIdtifiCardPath != null && !"".equals(nIdtifiCardPath) ){
			return AppConstants.portalSharePicHttpDir + nIdtifiCardPath;
		}
		return nIdtifiCardPath;
	}

	public void setnIdtifiCardPath(String nIdtifiCardPath) {
		this.nIdtifiCardPath = nIdtifiCardPath;
	}

	public String getBusinessLicensePath() {
		if( businessLicensePath != null && !"".equals(businessLicensePath) ){
			return AppConstants.portalSharePicHttpDir + businessLicensePath;
		}
		return businessLicensePath;
	}

	public void setBusinessLicensePath(String businessLicensePath) {
		this.businessLicensePath = businessLicensePath;
	}

	public String getOpenAccountLicensePath() {
		if( openAccountLicensePath != null && !"".equals(openAccountLicensePath) ){
			return AppConstants.portalSharePicHttpDir + openAccountLicensePath;
		}
		return openAccountLicensePath;
	}

	public void setOpenAccountLicensePath(String openAccountLicensePath) {
		this.openAccountLicensePath = openAccountLicensePath;
	}

	public String getQualityReportPath() {
		if( qualityReportPath != null && !"".equals(qualityReportPath) ){
			return AppConstants.portalSharePicHttpDir + qualityReportPath;
		}
		return qualityReportPath;
	}

	public void setQualityReportPath(String qualityReportPath) {
		this.qualityReportPath = qualityReportPath;
	}

	public String getCertificateRegistrationPath() {
		if( certificateRegistrationPath != null && !"".equals(certificateRegistrationPath) ){
			return AppConstants.portalSharePicHttpDir + certificateRegistrationPath;
		}
		return certificateRegistrationPath;
	}

	public void setCertificateRegistrationPath(String certificateRegistrationPath) {
		this.certificateRegistrationPath = certificateRegistrationPath;
	}

	public String getAuthorizationCertificatePath() {
		if( authorizationCertificatePath != null && !"".equals(authorizationCertificatePath) ){
			return AppConstants.portalSharePicHttpDir + authorizationCertificatePath;
		}
		return authorizationCertificatePath;
	}

	public void setAuthorizationCertificatePath(String authorizationCertificatePath) {
		this.authorizationCertificatePath = authorizationCertificatePath;
	}

	public String getStoreLogoPath() {
		if( storeLogoPath != null && !"".equals(storeLogoPath) ){
			return AppConstants.portalSharePicHttpDir + storeLogoPath;
		}
		return storeLogoPath;
	}

	public void setStoreLogoPath(String storeLogoPath) {
		this.storeLogoPath = storeLogoPath;
	}

	public String getStoreNumber() {
		return storeNumber;
	}

	public void setStoreNumber(String storeNumber) {
		this.storeNumber = storeNumber;
	}

}
