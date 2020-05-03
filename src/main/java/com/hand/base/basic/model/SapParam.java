package com.hand.base.basic.model;

import java.util.ArrayList;
import java.util.List;


public class SapParam {
	
	private List<String> list = new ArrayList<String>();

	public List<String> getList() {
		return list;
	}

	public void setList(List<String> list) {
		this.list = list;
	}
	
	
	@Override
	public String toString() {
		String result = ";";
		for(String str : list){
			result += str + "\n";
		}
		return result.substring(1);
	}

}
