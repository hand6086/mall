package com.hand.base.brandWorkbench.model;

import com.hand.base.basic.model.BasicModel;

public class Classify  extends BasicModel{
	
	/**
	 * 品牌馆分类信息
	 */
	private static final long serialVersionUID = 8829150611436746588L;
	private String name;	//名字		
	private String noName; // 排除
	private String isDisplay;	//是否展示
	private String displayOrder;	//展示顺序
	
	
	public String getNoName() {
		return noName;
	}
	public void setNoName(String noName) {
		this.noName = noName;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getIsDisplay() {
		return isDisplay;
	}
	public void setIsDisplay(String isDisplay) {
		this.isDisplay = isDisplay;
	}
	public String getDisplayOrder() {
		return displayOrder;
	}
	public void setDisplayOrder(String displayOrder) {
		this.displayOrder = displayOrder;
	}	
	
	
}
