package com.hand.base.common.model;

import java.util.List;

import com.hand.base.basic.model.BasicModel;

/**
 * 菜单类
 * @author ZHENGHONGDA
 *
 */
public class Menu extends BasicModel {
	
	private String iconCls;//弃用的字段？
	private String menuIcon;//菜单图标
	private String menuUrl;//菜单请求URL
	private String text;//菜单名称
	private String sortNumber;//排序号码
	private String state;//状态
	private String parentMenuId;//父菜单Id
	private String parentMenuName;//父菜单名称
	private String menuType;//菜单类型
	private String menuTypeName;//菜单类型名称
	private String comments;//说明
	private String dutyId;//职责Id
	private String menuGrade;//菜单等级
	private String oauthType;//安全性
	private String oauthSql;//其他安全性sql
	private String platformType;//所属系统(DMS/CRM)
	
	private String readonlyFlag;/* 菜单只读标记 */
	private String addFlag;/*菜单可新建标记 */
	private String editFlag;/*菜单可编辑标记*/
	private String deleteFlag;/*菜单可删除标记*/
	private String exportFlag;/*菜单可导出标记*/
	
	private String dutyReadonlyFlag;/*某职责下菜单只读标记*/
	private String dutyAddFlag;/* 某职责下菜单可新建标记 */
	private String dutyEditFlag;/* 某职责下菜单可编辑标记 */
	private String dutyDeleteFlag;/* 某职责下菜单可删除标记 */
	private String dutyExportFlag;/*某职责下菜单可导出 */
	
	/* *************************** */
	//以下这些字段为 行业版本 字段，必须与值列表中INDUSTRY_VERSION类型的独立源代码一一对应
	private String universalInd;/*通用版*/
	private String fmcgInd;/*快消行业版*/
	private String highTechInd;/*制造/高科技版*/
	private String homeInd;/*家居行业版*/
	private String finInd;/*金融行业版*/
	private String retailInd;/*零售行业版*/
	private String autoInd;/*汽车行业版*/
	/* *************************** */
	
	private List<Menu> children;
	private List<Menu> subMenus;
	
	public String getExportFlag() {
		return exportFlag;
	}

	public void setExportFlag(String exportFlag) {
		this.exportFlag = exportFlag;
	}

	public String getDutyExportFlag() {
		return dutyExportFlag;
	}

	public void setDutyExportFlag(String dutyExportFlag) {
		this.dutyExportFlag = dutyExportFlag;
	}

	public String getDutyReadonlyFlag() {
		return dutyReadonlyFlag;
	}

	public void setDutyReadonlyFlag(String dutyReadonlyFlag) {
		this.dutyReadonlyFlag = dutyReadonlyFlag;
	}

	public String getDutyAddFlag() {
		return dutyAddFlag;
	}

	public void setDutyAddFlag(String dutyAddFlag) {
		this.dutyAddFlag = dutyAddFlag;
	}

	public String getDutyEditFlag() {
		return dutyEditFlag;
	}

	public void setDutyEditFlag(String dutyEditFlag) {
		this.dutyEditFlag = dutyEditFlag;
	}

	public String getDutyDeleteFlag() {
		return dutyDeleteFlag;
	}

	public void setDutyDeleteFlag(String dutyDeleteFlag) {
		this.dutyDeleteFlag = dutyDeleteFlag;
	}

	public String getReadonlyFlag() {
		return readonlyFlag;
	}

	public void setReadonlyFlag(String readonlyFlag) {
		this.readonlyFlag = readonlyFlag;
	}

	public String getAddFlag() {
		return addFlag;
	}

	public void setAddFlag(String addFlag) {
		this.addFlag = addFlag;
	}

	public String getEditFlag() {
		return editFlag;
	}

	public void setEditFlag(String editFlag) {
		this.editFlag = editFlag;
	}

	public String getDeleteFlag() {
		return deleteFlag;
	}

	public void setDeleteFlag(String deleteFlag) {
		this.deleteFlag = deleteFlag;
	}

	public String getMenuGrade() {
		return menuGrade;
	}

	public void setMenuGrade(String menuGrade) {
		this.menuGrade = menuGrade;
	}

	public Menu() {
	}
	
	public String getMenuIcon() {
		return menuIcon;
	}

	public void setMenuIcon(String menuIcon) {
		this.menuIcon = menuIcon;
	}

	public String getIconCls() {
		return iconCls;
	}

	public void setIconCls(String iconCls) {
		this.iconCls = iconCls;
	}

	public String getMenuUrl() {
		return menuUrl;
	}

	public void setMenuUrl(String menuUrl) {
		this.menuUrl = menuUrl;
	}

	public List<Menu> getChildren() {
		return children;
	}

	public void setChildren(List<Menu> children) {
		this.children = children;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getParentMenuId() {
		return parentMenuId;
	}

	public void setParentMenuId(String parentMenuId) {
		this.parentMenuId = parentMenuId;
	}

	public String getParentMenuName() {
		return parentMenuName;
	}

	public void setParentMenuName(String parentMenuName) {
		this.parentMenuName = parentMenuName;
	}

	public String getDutyId() {
		return dutyId;
	}

	public void setDutyId(String dutyId) {
		this.dutyId = dutyId;
	}

	public String getMenuType() {
		return menuType;
	}

	public void setMenuType(String menuType) {
		this.menuType = menuType;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getMenuTypeName() {
		return menuTypeName;
	}

	public void setMenuTypeName(String menuTypeName) {
		this.menuTypeName = menuTypeName;
	}

	public String getSortNumber() {
		return sortNumber;
	}

	public void setSortNumber(String sortNumber) {
		this.sortNumber = sortNumber;
	}

	public List<Menu> getSubMenus() {
		return subMenus;
	}

	public void setSubMenus(List<Menu> subMenus) {
		this.subMenus = subMenus;
	}

	public String getOauthType() {
		return oauthType;
	}

	public void setOauthType(String oauthType) {
		this.oauthType = oauthType;
	}

	public String getOauthSql() {
		return oauthSql;
	}

	public void setOauthSql(String oauthSql) {
		this.oauthSql = oauthSql;
	}

	public String getPlatformType() {
		return platformType;
	}

	public void setPlatformType(String platformType) {
		this.platformType = platformType;
	}

	public String getUniversalInd() {
		return universalInd;
	}

	public void setUniversalInd(String universalInd) {
		this.universalInd = universalInd;
	}

	public String getFmcgInd() {
		return fmcgInd;
	}

	public void setFmcgInd(String fmcgInd) {
		this.fmcgInd = fmcgInd;
	}

	public String getHighTechInd() {
		return highTechInd;
	}

	public void setHighTechInd(String highTechInd) {
		this.highTechInd = highTechInd;
	}

	public String getHomeInd() {
		return homeInd;
	}

	public void setHomeInd(String homeInd) {
		this.homeInd = homeInd;
	}

	public String getFinInd() {
		return finInd;
	}

	public void setFinInd(String finInd) {
		this.finInd = finInd;
	}

	public String getRetailInd() {
		return retailInd;
	}

	public void setRetailInd(String retailInd) {
		this.retailInd = retailInd;
	}

	public String getAutoInd() {
		return autoInd;
	}

	public void setAutoInd(String autoInd) {
		this.autoInd = autoInd;
	}
	
}
