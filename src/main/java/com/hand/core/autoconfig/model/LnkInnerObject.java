package com.hand.core.autoconfig.model;

import java.util.List;

import com.hand.base.basic.model.BasicModel;

public class LnkInnerObject extends BasicModel {
	private String	name;			/* 名称 */
	private String	newflag;		/* 新建 */
	private String	updateflag;		/* 更新 */
	private String	deleteflag;		/* 删除 */
	private String	queryflag;		/* 查询 */
	private String	basetable;		/* 基表 */
	private String	basetablealais;	/* 基表别名 */
	private String	activeflag;		/* 是否有效 */
	private String	orderbyfield;	/* 排序字段 */
	private String	coms;			/* 说明 */
	private String	createdByName;	/* 创建者姓名 */
	private String	attr01;			/* 备注1 显示名称 */
	private String	attr02;			/* 备注2 项目名称*/
	private String	attr03;			/* 备注3 文件夹名称*/
	private String	attr04;	/* 备注4 crm包名 */
	private String	attr05;	/* 备注5 */
	private String	attr06;	/* 备注6 */
	private String	attr07;	/* 备注7 */
	private String	attr08;	/* 备注8 */
	private String	attr09;	/* 备注9 数据源*/
	private String	attr10;	/* 备注10 app公司账套*/
	private String	attr11;	/* 备注attr11 */
	private String	attr12;	/* 备注attr12 */
	private String	attr13;	/* 备注attr13 */
	private String	attr14;	/* 备注attr14 */
	private String	attr15;	/* 备注attr15 */
	private String	attr16;	/* 备注attr16 */
	private String	attr17;	/* 备注attr17 */
	private String	attr18;	/* 备注attr18 app包名 */
	private String	attr19;	/* 备注attr19 */
	private String	attr20;	/* 备注attr20 */
	private String	attr21;	/* 备注attr21 */
	private String	attr22;	/* 备注attr22 */
	private String	attr23;	/* 备注attr23 */
	private String	attr24;	/* 备注attr24 */
	private String	attr25;	/* 备注attr25 */
	private String	attr26;	/* 备注attr26 */
	private String	attr27;	/* 备注attr27 */
	private String	attr28;	/* 备注attr28 */
	private String	attr29;	/* 备注attr29 */
	private String	attr30;	/* 备注attr30 */
	
	private List<LnkInnerField> fieldList;	/*字段表*/
	private List<LnkInnerLink> linkList;	/*关联表*/
	private List<LnkInnerWhere> whereList;	/*筛选条件*/
	private Boolean fullObjFlag = false;
	
	public List<LnkInnerField> getFieldList() {
		return fieldList;
	}

	public void setFieldList(List<LnkInnerField> fieldList) {
		this.fieldList = fieldList;
	}

	public List<LnkInnerLink> getLinkList() {
		return linkList;
	}

	public void setLinkList(List<LnkInnerLink> linkList) {
		this.linkList = linkList;
	}

	public List<LnkInnerWhere> getWhereList() {
		return whereList;
	}

	public void setWhereList(List<LnkInnerWhere> whereList) {
		this.whereList = whereList;
	}

	public Boolean getFullObjFlag() {
		return fullObjFlag;
	}

	public void setFullObjFlag(Boolean fullObjFlag) {
		this.fullObjFlag = fullObjFlag;
	}

	public String getName() {
		return name;
	}
	
	public String getCreatedByName() {
		return createdByName;
	}
	
	public void setCreatedByName(String createdByName) {
		this.createdByName = createdByName;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getNewflag() {
		return newflag;
	}
	
	public void setNewflag(String newflag) {
		this.newflag = newflag;
	}
	
	public String getUpdateflag() {
		return updateflag;
	}
	
	public void setUpdateflag(String updateflag) {
		this.updateflag = updateflag;
	}
	
	public String getDeleteflag() {
		return deleteflag;
	}
	
	public void setDeleteflag(String deleteflag) {
		this.deleteflag = deleteflag;
	}
	
	public String getQueryflag() {
		return queryflag;
	}
	
	public void setQueryflag(String queryflag) {
		this.queryflag = queryflag;
	}
	
	public String getBasetable() {
		return basetable;
	}
	
	public void setBasetable(String basetable) {
		this.basetable = basetable;
	}
	
	public String getBasetablealais() {
		return basetablealais;
	}
	
	public void setBasetablealais(String basetablealais) {
		this.basetablealais = basetablealais;
	}
	
	public String getActiveflag() {
		return activeflag;
	}
	
	public void setActiveflag(String activeflag) {
		this.activeflag = activeflag;
	}
	
	public String getOrderbyfield() {
		return orderbyfield;
	}
	
	public void setOrderbyfield(String orderbyfield) {
		this.orderbyfield = orderbyfield;
	}
	
	public String getComs() {
		return coms;
	}
	
	public void setComs(String coms) {
		this.coms = coms;
	}
	
	public String getAttr01() {
		return attr01;
	}
	
	public void setAttr01(String attr01) {
		this.attr01 = attr01;
	}
	
	public String getAttr02() {
		return attr02;
	}
	
	public void setAttr02(String attr02) {
		this.attr02 = attr02;
	}
	
	public String getAttr03() {
		return attr03;
	}
	
	public void setAttr03(String attr03) {
		this.attr03 = attr03;
	}
	
	public String getAttr04() {
		return attr04;
	}
	
	public void setAttr04(String attr04) {
		this.attr04 = attr04;
	}
	
	public String getAttr05() {
		return attr05;
	}
	
	public void setAttr05(String attr05) {
		this.attr05 = attr05;
	}
	
	public String getAttr06() {
		return attr06;
	}
	
	public void setAttr06(String attr06) {
		this.attr06 = attr06;
	}
	
	public String getAttr07() {
		return attr07;
	}
	
	public void setAttr07(String attr07) {
		this.attr07 = attr07;
	}
	
	public String getAttr08() {
		return attr08;
	}
	
	public void setAttr08(String attr08) {
		this.attr08 = attr08;
	}
	
	public String getAttr09() {
		return attr09;
	}
	
	public void setAttr09(String attr09) {
		this.attr09 = attr09;
	}
	
	public String getAttr10() {
		return attr10;
	}
	
	public void setAttr10(String attr10) {
		this.attr10 = attr10;
	}
							
	public String getAttr11() {
		return attr11;
	}
	
	public void setAttr11(String attr11) {
		this.attr11 = attr11;
	}
	
	public String getAttr12() {
		return attr12;
	}
	
	public void setAttr12(String attr12) {
		this.attr12 = attr12;
	}
	
	public String getAttr13() {
		return attr13;
	}
	
	public void setAttr13(String attr13) {
		this.attr13 = attr13;
	}
	
	public String getAttr14() {
		return attr14;
	}
	
	public void setAttr14(String attr14) {
		this.attr14 = attr14;
	}
	
	public String getAttr15() {
		return attr15;
	}
	
	public void setAttr15(String attr15) {
		this.attr15 = attr15;
	}
	
	public String getAttr16() {
		return attr16;
	}
	
	public void setAttr16(String attr16) {
		this.attr16 = attr16;
	}
	
	public String getAttr17() {
		return attr17;
	}
	
	public void setAttr17(String attr17) {
		this.attr17 = attr17;
	}
	
	public String getAttr18() {
		return attr18;
	}
	
	public void setAttr18(String attr18) {
		this.attr18 = attr18;
	}
	
	public String getAttr19() {
		return attr19;
	}
	
	public void setAttr19(String attr19) {
		this.attr19 = attr19;
	}
	
	public String getAttr20() {
		return attr20;
	}
	
	public void setAttr20(String attr20) {
		this.attr20 = attr20;
	}
	
	public String getAttr21() {
		return attr21;
	}
	
	public void setAttr21(String attr21) {
		this.attr21 = attr21;
	}
	
	public String getAttr22() {
		return attr22;
	}
	
	public void setAttr22(String attr22) {
		this.attr22 = attr22;
	}
	
	public String getAttr23() {
		return attr23;
	}
	
	public void setAttr23(String attr23) {
		this.attr23 = attr23;
	}
	
	public String getAttr24() {
		return attr24;
	}
	
	public void setAttr24(String attr24) {
		this.attr24 = attr24;
	}
	
	public String getAttr25() {
		return attr25;
	}
	
	public void setAttr25(String attr25) {
		this.attr25 = attr25;
	}
	
	public String getAttr26() {
		return attr26;
	}
	
	public void setAttr26(String attr26) {
		this.attr26 = attr26;
	}
	
	public String getAttr27() {
		return attr27;
	}
	
	public void setAttr27(String attr27) {
		this.attr27 = attr27;
	}
	
	public String getAttr28() {
		return attr28;
	}
	
	public void setAttr28(String attr28) {
		this.attr28 = attr28;
	}
	
	public String getAttr29() {
		return attr29;
	}
	
	public void setAttr29(String attr29) {
		this.attr29 = attr29;
	}
	
	public String getAttr30() {
		return attr30;
	}
	
	public void setAttr30(String attr30) {
		this.attr30 = attr30;
	}
}
