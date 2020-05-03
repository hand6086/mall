package com.hand.base.mvg.model;

import com.hand.base.basic.model.BasicModel;

/**
 * MVG导入
 * @author heqiqian
 *
 */
public class Mvg extends BasicModel{
//	private String mvgParentId;		//父表ID
	private String mvgSubsetId;		//子表ID
	private String mvgMapperName;	//要启用的mapper实现类名称
	private Boolean queryDefaultFlag = false;	//是否查询子表主要ID
	private String defField;		//主要列的名称
	
	private String mvgAttr1;		//备用字段
	private String mvgAttr2;		//备用字段
	private String mvgAttr3;		//备用字段
	private String mvgAttr4;		//备用字段
	private String mvgAttr5;		//备用字段
	
	
	public String getMvgSubsetId() {
		return mvgSubsetId;
	}
	public void setMvgSubsetId(String mvgSubsetId) {
		this.mvgSubsetId = mvgSubsetId;
	}
	public String getMvgMapperName() {
		return mvgMapperName;
	}
	public void setMvgMapperName(String mvgMapperName) {
		this.mvgMapperName = mvgMapperName;
	}
	public Boolean getQueryDefaultFlag() {
		return queryDefaultFlag;
	}
	public void setQueryDefaultFlag(Boolean queryDefaultFlag) {
		this.queryDefaultFlag = queryDefaultFlag;
	}
	public String getDefField() {
		return defField;
	}
	public void setDefField(String defField) {
		this.defField = defField;
	}
	public String getMvgAttr1() {
		return mvgAttr1;
	}
	public void setMvgAttr1(String mvgAttr1) {
		this.mvgAttr1 = mvgAttr1;
	}
	public String getMvgAttr2() {
		return mvgAttr2;
	}
	public void setMvgAttr2(String mvgAttr2) {
		this.mvgAttr2 = mvgAttr2;
	}
	public String getMvgAttr3() {
		return mvgAttr3;
	}
	public void setMvgAttr3(String mvgAttr3) {
		this.mvgAttr3 = mvgAttr3;
	}
	public String getMvgAttr4() {
		return mvgAttr4;
	}
	public void setMvgAttr4(String mvgAttr4) {
		this.mvgAttr4 = mvgAttr4;
	}
	public String getMvgAttr5() {
		return mvgAttr5;
	}
	public void setMvgAttr5(String mvgAttr5) {
		this.mvgAttr5 = mvgAttr5;
	}
	
}
