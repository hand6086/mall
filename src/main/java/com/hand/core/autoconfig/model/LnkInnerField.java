package com.hand.core.autoconfig.model;
import com.hand.base.basic.model.BasicModel;
public class LnkInnerField extends BasicModel{

 
	private String name;/*字段名称*/
	private String joinname;/*连接*/
	private String table;/*表*/
	private String columnname;/*列名称*/
	private String queryflag;/*查询标记*/
	private String orderflag;/*排序标记*/
	private String activeflag;/*激活的*/
	private String displayname;/*显示名称*/
	private String updateflag;/*可更新*/
	private String insertflag;/*可插入*/
	private String uireadonly;/*界面只读*/
	private String uitype;/*界面类型*/
	private String fieldtype;/*字段类型*/
	private String columntype;/*列类型*/
	private String columnlength;/*列长度*/
	private String calcflag;/*计算字段*/
	private String calc;/*计算逻辑*/
	private String lovtype;/*值列表*/
	private String uirequired;/*界面必输*/
	private String uiqueryflag;/*界面可查询*/
	private String indextype;/*索引类型*/
	private String coms;/*说明*/
	private String attr01;/*备注1*/
	private String attr02;/*备注2 是否有效*/
	private String attr03;/*备注3 界面快速筛选*/
	private String attr04;/*备注4 app界面类型*/
	private String attr05;/*备注5 是否有提示 placeholder*/
	private String attr06;/*备注6 文本可清除 closeicon*/
	private String attr07;/*备注7 app页面条件只读配置*/
	private String attr08;/*备注8 是否多语言标记*/
	private String attr09;/*备注9 多语言表达式*/
	private String attr10;
	
	private String parentid;
	
	
	
	
	public String getParentid() {
		return parentid;
	}
	public void setParentid(String parentid) {
		this.parentid = parentid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getJoinname() {
		return joinname;
	}
	public void setJoinname(String joinname) {
		this.joinname = joinname;
	}
	public String getTable() {
		return table;
	}
	public void setTable(String table) {
		this.table = table;
	}
	public String getColumnname() {
		return columnname;
	}
	public void setColumnname(String columnname) {
		this.columnname = columnname;
	}
	public String getQueryflag() {
		return queryflag;
	}
	public void setQueryflag(String queryflag) {
		this.queryflag = queryflag;
	}
	public String getOrderflag() {
		return orderflag;
	}
	public void setOrderflag(String orderflag) {
		this.orderflag = orderflag;
	}
	public String getActiveflag() {
		return activeflag;
	}
	public void setActiveflag(String activeflag) {
		this.activeflag = activeflag;
	}
	public String getDisplayname() {
		return displayname;
	}
	public void setDisplayname(String displayname) {
		this.displayname = displayname;
	}
	public String getUpdateflag() {
		return updateflag;
	}
	public void setUpdateflag(String updateflag) {
		this.updateflag = updateflag;
	}
	public String getInsertflag() {
		return insertflag;
	}
	public void setInsertflag(String insertflag) {
		this.insertflag = insertflag;
	}
	public String getUireadonly() {
		return uireadonly;
	}
	public void setUireadonly(String uireadonly) {
		this.uireadonly = uireadonly;
	}
	public String getUitype() {
		return uitype;
	}
	public void setUitype(String uitype) {
		this.uitype = uitype;
	}
	public String getFieldtype() {
		return fieldtype;
	}
	public void setFieldtype(String fieldtype) {
		this.fieldtype = fieldtype;
	}
	public String getColumntype() {
		return columntype;
	}
	public void setColumntype(String columntype) {
		this.columntype = columntype;
	}
	public String getColumnlength() {
		return columnlength;
	}
	public void setColumnlength(String columnlength) {
		this.columnlength = columnlength;
	}
	public String getCalcflag() {
		return calcflag;
	}
	public void setCalcflag(String calcflag) {
		this.calcflag = calcflag;
	}
	public String getCalc() {
		return calc;
	}
	public void setCalc(String calc) {
		this.calc = calc;
	}
	public String getLovtype() {
		return lovtype;
	}
	public void setLovtype(String lovtype) {
		this.lovtype = lovtype;
	}
	public String getUirequired() {
		return uirequired;
	}
	public void setUirequired(String uirequired) {
		this.uirequired = uirequired;
	}
	public String getUiqueryflag() {
		return uiqueryflag;
	}
	public void setUiqueryflag(String uiqueryflag) {
		this.uiqueryflag = uiqueryflag;
	}
	public String getIndextype() {
		return indextype;
	}
	public void setIndextype(String indextype) {
		this.indextype = indextype;
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
	}/*备注10*/


	
}
