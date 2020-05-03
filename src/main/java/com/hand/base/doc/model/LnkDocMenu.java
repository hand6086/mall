package com.hand.base.doc.model;

import java.util.ArrayList;
import java.util.List;

import com.hand.base.basic.model.BasicModel;

public class LnkDocMenu extends BasicModel{

	/**
	 * 
	 */
	private static final long serialVersionUID = 7942551444508859957L;
	private String menuName;           	/*菜单名称*/
	private String menuIcon;           	/*菜单图标*/
	
	private List<LnkDocMenuLine> menuLineList = new ArrayList<LnkDocMenuLine>();


	public String getMenuName() {
		return menuName;
	}
	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}

	public String getMenuIcon() {
		return menuIcon;
	}
	public void setMenuIcon(String menuIcon) {
		this.menuIcon = menuIcon;
	}
	public List<LnkDocMenuLine> getMenuLineList() {
		return menuLineList;
	}
	public void setMenuLineList(List<LnkDocMenuLine> menuLineList) {
		this.menuLineList = menuLineList;
	}
}
