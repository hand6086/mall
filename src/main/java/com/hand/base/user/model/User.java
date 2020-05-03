package com.hand.base.user.model;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import org.springframework.security.core.userdetails.UserDetails;

import com.hand.base.basic.model.BasicModel;
import com.hand.base.user.authority.RoleGrantedAuthority;

public class User extends BasicModel implements UserDetails{

	private static final long serialVersionUID = 9116249677517267208L;
	public static final int MAX_LOGIN_ERROR_TIME = 5;//登录密码错误限制的次数
	
	public static final String ROLE_ADMIN = "ROLE_ADMIN";//管理员角色
	public static final String ROLE_DEALER_ADMIN = "ROLE_DEALER_ADMIN";//经销商管理员角色
	public static final String ROLE_DEALER_ORDER = "ROLE_DEALER_ORDER";//经销商下单角色
	public static final String ROLE_DEALER_FINANCE = "ROLE_DEALER_FINANCE";//经销商财务角色
	public static final String ROLE_USER = "ROLE_USER";//游客角色
	
	public static final String ROLE_ADMIN_CHS = "管理员";//管理员角色
	public static final String ROLE_DEALER_ADMIN_CHS = "经销商管理人员";//经销商管理员角色
	public static final String ROLE_DEALER_ORDER_CHS = "下单人员";//经销商下单角色
	public static final String ROLE_DEALER_FINANCE_CHS = "财务人员";//经销商财务角色
	public static final String ROLE_USER_CHS = "游客";//游客角色
	
	private String username;//用户名
	private String password;//密码
	private String firstName;//姓名
	private String dutyId;//职责Id
	private String dutyName;//职责名称
	private String postnId;//职位Id
	private String postnName;//职位名称
	private String deptId;		//部门Id
	private String deptName;	//部门名称
	private String orgId;//组织Id
	private String orgCode;
	private String orgName;//组织名称
	private String status;//状态
	private String empTypeLovType;
	private String empType;//员工类型
	private String role;//用户角色
	private String contact;//联系人
	private String email;
	private String basename;
	private String formuladate;
	private String hometown;
	private String joblevel;
	private String joindate;
	private String joingroupdate;
	private String nextproj;
	private String positionname;
	private String trialdate;
	private String unitname;
	private String workdate;
	private String appRole;
	private String appResp;
	private String errorMessage;//错误信息
	private String scancardFlag;//名片掃描
	private String lastLoginDate;//最后登录时间
	private String gender;//性别 值列表：GENDER
	private String qixinbaoFlag;//启信宝
	
	private String customerServiceId;//企点客服ID
	private String customerService;//企点客服
	private String qdUserOpenid;//用户企点OPENID
	private String qdIsQduser;//是否企点用户
	private String qdAssStatus;//企点分配状态 值列表：QD_ASSIGNE_STATUS
	private String qdPrivTypeId;//企点权限类型ID
	private String qdPrivTypeName;//企点权限类型名称
	
	private String leaderId; //汇报领导ID
	private String leader; //汇报领导
	private String currentProject; //目前项目
	private String proRole;//项目角色
	private String enterProjDate;//入场时间
	private String releaseDate;//计划释放时间
	private String sourceStatus;//资源状态
	private String planComments;//后续项目安排及备注	
	private String timesheet;//近期timesheet	
	private String updateVersion;//更新版本
	
 	private String integrationId;// 集成Id
    private String source; //产品来源
    private String systemRole; //系统角色
    private String storeStatus;//商户审批状态
	private String zhEmail;//智齿邮箱
	
    
	public String getStoreStatus() {
		return storeStatus;
	}
	public void setStoreStatus(String storeStatus) {
		this.storeStatus = storeStatus;
	}
	public String getLeader() {
		return leader;
	}
	public void setLeader(String leader) {
		this.leader = leader;
	}
	public String getCurrentProject() {
		return currentProject;
	}
	public void setCurrentProject(String currentProject) {
		this.currentProject = currentProject;
	}
	public String getProRole() {
		return proRole;
	}
	public void setProRole(String proRole) {
		this.proRole = proRole;
	}
	public String getEnterProjDate() {
		return enterProjDate;
	}
	public void setEnterProjDate(String enterProjDate) {
		this.enterProjDate = enterProjDate;
	}
	public String getReleaseDate() {
		return releaseDate;
	}
	public void setReleaseDate(String releaseDate) {
		this.releaseDate = releaseDate;
	}
	public String getSourceStatus() {
		return sourceStatus;
	}
	public void setSourceStatus(String sourceStatus) {
		this.sourceStatus = sourceStatus;
	}
	public String getPlanComments() {
		return planComments;
	}
	public void setPlanComments(String planComments) {
		this.planComments = planComments;
	}
	public String getTimesheet() {
		return timesheet;
	}
	public void setTimesheet(String timesheet) {
		this.timesheet = timesheet;
	}
	public String getUpdateVersion() {
		return updateVersion;
	}
	public void setUpdateVersion(String updateVersion) {
		this.updateVersion = updateVersion;
	}

	public String getScancardFlag() {
		return scancardFlag;
	}
	public void setScancardFlag(String scancardFlag) {
		this.scancardFlag = scancardFlag;
	}
	public String getAppResp() {
		return appResp;
	}
	public void setAppResp(String appResp) {
		this.appResp = appResp;
	}
	public String getAppRole() {
		return appRole;
	}
	public void setAppRole(String appRole) {
		this.appRole = appRole;
	}
	public String getBasename() {
		return basename;
	}
	public void setBasename(String basename) {
		this.basename = basename;
	}
	public String getFormuladate() {
		return formuladate;
	}
	public void setFormuladate(String formuladate) {
		this.formuladate = formuladate;
	}
	public String getHometown() {
		return hometown;
	}
	public void setHometown(String hometown) {
		this.hometown = hometown;
	}
	public String getJoblevel() {
		return joblevel;
	}
	public void setJoblevel(String joblevel) {
		this.joblevel = joblevel;
	}
	public String getJoindate() {
		return joindate;
	}
	public void setJoindate(String joindate) {
		this.joindate = joindate;
	}
	public String getJoingroupdate() {
		return joingroupdate;
	}
	public void setJoingroupdate(String joingroupdate) {
		this.joingroupdate = joingroupdate;
	}
	public String getNextproj() {
		return nextproj;
	}
	public void setNextproj(String nextproj) {
		this.nextproj = nextproj;
	}
	public String getPositionname() {
		return positionname;
	}
	public void setPositionname(String positionname) {
		this.positionname = positionname;
	}
	public String getTrialdate() {
		return trialdate;
	}
	public void setTrialdate(String trialdate) {
		this.trialdate = trialdate;
	}
	public String getUnitname() {
		return unitname;
	}
	public void setUnitname(String unitname) {
		this.unitname = unitname;
	}
	public String getWorkdate() {
		return workdate;
	}
	public void setWorkdate(String workdate) {
		this.workdate = workdate;
	}
 
	private String contactPhone;//联系电话
	 

	private Integer errorTimes;//当天登录失败次数
	/**角色值列表类型*/
	private String roleLovType;
	/**状态值列表类型*/
	private String statusLovType;
	/**公司代码*/
	private String companyCode;
	/**公司代码值列表类型*/
	private String companyCodeLovType; 
	
	private String acctId;
	private String acctCode;
	/**法人*/
	private String acctName;
	/**客户名称*/
	private String acctAgencyName;
	private String acctType;
	private String acctGroup;//客户组
	private String entryDate;
	
	/**是否默认*/
	private String isDefault;
	
	@SuppressWarnings("unused")
	private String showCurrentDate;	//界面展示当前日期
	
	public Collection<RoleGrantedAuthority> getAuthorities() {
		List<RoleGrantedAuthority> authorityList = new ArrayList<RoleGrantedAuthority>();
		if(this.role != null){
			String role = this.role.trim();
			if(role.equalsIgnoreCase("管理员")){
				//设置管理员角色
				authorityList.add(new RoleGrantedAuthority(ROLE_ADMIN));
			}else if(role.equalsIgnoreCase("经销商管理人员")){
				//设置经销商管理员角色
				authorityList.add(new RoleGrantedAuthority(ROLE_DEALER_ADMIN));
			}else if(role.equalsIgnoreCase("下单人员")){
				//设置经销商下单角色 
				authorityList.add(new RoleGrantedAuthority(ROLE_DEALER_ORDER));
			}else if(role.equalsIgnoreCase("财务人员")){
				//设置经销商财务角色 
				authorityList.add(new RoleGrantedAuthority(ROLE_DEALER_FINANCE));
			}else{
				//如果不是以上角色，设置为游客用户角色
				authorityList.add(new RoleGrantedAuthority(ROLE_USER));
			}
			
		}
		return authorityList;
	}
	
	public String getDutyId() {
		return dutyId;
	}
	public void setDutyId(String dutyId) {
		this.dutyId = dutyId;
	}
	public String getDutyName() {
		return dutyName;
	}
	public void setDutyName(String dutyName) {
		this.dutyName = dutyName;
	}
	public String getAcctId() {
		return acctId;
	}
	public void setAcctId(String acctId) {
		this.acctId = acctId;
	}
	public String getAcctCode() {
		return acctCode;
	}
	public void setAcctCode(String acctCode) {
		this.acctCode = acctCode;
	}
	public String getAcctName() {
		return acctName;
	}
	public void setAcctName(String acctName) {
		this.acctName = acctName;
	}
	public String getOrgId() {
		return orgId;
	}
	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}
	public String getOrgName() {
		return orgName;
	}
	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}
	public String getPostnId() {
		return postnId;
	}
	public void setPostnId(String postnId) {
		this.postnId = postnId;
	}
	public String getPostnName() {
		return postnName;
	}
	public void setPostnName(String postnName) {
		this.postnName = postnName;
	}
	public String getContact() {
		return contact;
	}
	public void setContact(String contact) {
		this.contact = contact;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getEntryDate() {
		return entryDate;
	}
	public void setEntryDate(String entryDate) {
		this.entryDate = entryDate;
	}
	public String getEmpType() {
		return empType;
	}
	public void setEmpType(String empType) {
		this.empType = empType;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	public Integer getErrorTimes() {
		return errorTimes;
	}

	public void setErrorTimes(Integer errorTimes) {
		this.errorTimes = errorTimes;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}
	
	public String getAcctGroup() {
		return acctGroup;
	}

	public void setAcctGroup(String acctGroup) {
		this.acctGroup = acctGroup;
	}

	public String getOrgCode() {
		return orgCode;
	}

	public void setOrgCode(String orgCode) {
		this.orgCode = orgCode;
	}

	public String getContactPhone() {
		return contactPhone;
	}

	public void setContactPhone(String contactPhone) {
		this.contactPhone = contactPhone;
	}

	/**
	 * 账号是否过期
	 * @see org.springframework.security.core.userdetails.UserDetails#isAccountNonExpired()
	 */
	public boolean isAccountNonExpired() {
		return true;
	}
	
	/**
	 * 账号是否锁定
	 * @see org.springframework.security.core.userdetails.UserDetails#isAccountNonLocked()
	 */
	public boolean isAccountNonLocked() {
		//如果用用户每天登录失败超过最大设定次数，当天账号锁定 
		if(this.errorTimes == null){
			return true;
		}
		if(this.errorTimes >= 0 && this.errorTimes < MAX_LOGIN_ERROR_TIME ){
			return true;
		}else{
			return false;
		}
	}
	
	/**
	 * 密码是否过期
	 */
	public boolean isCredentialsNonExpired() {
		return true;
	}
	
	/**
	 * 账号是否失效
	 * @see org.springframework.security.core.userdetails.UserDetails#isAccountNonLocked()
	 */
	public boolean isEnabled() {
		return true;
	}
	
	/**
	 * 是否为管理员角色
	 */
	public boolean isAdmin() {
		if(this.role != null){
			String role = this.role.trim();
			if(role.equalsIgnoreCase("WD Admin")){
				return true;
			}else{
				return false;
			}
		}else{
			return false;
		}
	}

	public String getShowCurrentDate() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd日");
		return sdf.format(new Date());
	}

	public void setShowCurrentDate(String showCurrentDate) {
		this.showCurrentDate = showCurrentDate;
	}

	public String getAcctType() {
		return acctType;
	}

	public void setAcctType(String acctType) {
		this.acctType = acctType;
	}

	public String getEmpTypeLovType() {
		return empTypeLovType;
	}

	public void setEmpTypeLovType(String empTypeLovType) {
		this.empTypeLovType = empTypeLovType;
	}

	public String getRoleLovType() {
		return roleLovType;
	}

	public void setRoleLovType(String roleLovType) {
		this.roleLovType = roleLovType;
	}

	public String getStatusLovType() {
		return statusLovType;
	}

	public void setStatusLovType(String statusLovType) {
		this.statusLovType = statusLovType;
	}

	public String getIsDefault() {
		return isDefault;
	}

	public void setIsDefault(String isDefault) {
		this.isDefault = isDefault;
	}

	public String getAcctAgencyName() {
		return acctAgencyName;
	}

	public void setAcctAgencyName(String acctAgencyName) {
		this.acctAgencyName = acctAgencyName;
	}

	public String getCompanyCode() {
		return companyCode;
	}

	public void setCompanyCode(String companyCode) {
		this.companyCode = companyCode;
	}

	public String getCompanyCodeLovType() {
		return companyCodeLovType;
	}

	public void setCompanyCodeLovType(String companyCodeLovType) {
		this.companyCodeLovType = companyCodeLovType;
	}
	public String getDeptId() {
		return deptId;
	}
	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public String getErrorMessage() {
		return errorMessage;
	}
	public void setErrorMessage(String errorMessage) {
		this.errorMessage = errorMessage;
	}
	public String getLastLoginDate() {
		return lastLoginDate;
	}
	public void setLastLoginDate(String lastLoginDate) {
		this.lastLoginDate = lastLoginDate;
	}
	public String getCustomerService() {
		return customerService;
	}
	public void setCustomerService(String customerService) {
		this.customerService = customerService;
	}
	public String getCustomerServiceId() {
		return customerServiceId;
	}
	public void setCustomerServiceId(String customerServiceId) {
		this.customerServiceId = customerServiceId;
	}
	public String getLeaderId() {
		return leaderId;
	}
	public void setLeaderId(String leaderId) {
		this.leaderId = leaderId;
	}
	public String getQdUserOpenid() {
		return qdUserOpenid;
	}
	public void setQdUserOpenid(String qdUserOpenid) {
		this.qdUserOpenid = qdUserOpenid;
	}
	public String getQdIsQduser() {
		return qdIsQduser;
	}
	public void setQdIsQduser(String qdIsQduser) {
		this.qdIsQduser = qdIsQduser;
	}
	public String getQdAssStatus() {
		return qdAssStatus;
	}
	public void setQdAssStatus(String qdAssStatus) {
		this.qdAssStatus = qdAssStatus;
	}
	public String getQdPrivTypeId() {
		return qdPrivTypeId;
	}
	public void setQdPrivTypeId(String qdPrivTypeId) {
		this.qdPrivTypeId = qdPrivTypeId;
	}
	public String getQdPrivTypeName() {
		return qdPrivTypeName;
	}
	public void setQdPrivTypeName(String qdPrivTypeName) {
		this.qdPrivTypeName = qdPrivTypeName;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getIntegrationId() {
		return integrationId;
	}
	public void setIntegrationId(String integrationId) {
		this.integrationId = integrationId;
	}
	public String getSource() {
		return source;
	}
	public void setSource(String source) {
		this.source = source;
	}
    public String getQixinbaoFlag() {
        return qixinbaoFlag;
    }
    public void setQixinbaoFlag(String qixinbaoFlag) {
        this.qixinbaoFlag = qixinbaoFlag;
    }
	public String getSystemRole() {
		return systemRole;
	}
	public void setSystemRole(String systemRole) {
		this.systemRole = systemRole;
	}

	public String getZhEmail() {
		return zhEmail;
	}

	public void setZhEmail(String zhEmail) {
		this.zhEmail = zhEmail;
	}
}
