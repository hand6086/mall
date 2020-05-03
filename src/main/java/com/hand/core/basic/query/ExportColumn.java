package com.hand.core.basic.query;

import java.util.Map;

import com.hand.core.util.StringUtils;

public class ExportColumn implements Comparable<ExportColumn>{
	private String title;
	private String field;
	private Integer order;
	private String lov;//值列表类型
	private boolean trLovFlag = true;//导出时是否转换为显示值
	private Map<String, String> lovMap;
	
	/**
	 * 
	 *<p>获取值列表显示值</p>
	 * @author yrf
	 * @param lovCode
	 * @return
	 */
	public String getLovShowName(String lovCode){
		if(trLovFlag){
			if( lovMap != null ){
				String lovName = lovMap.get(lovCode);
				if(StringUtils.isNull(lovName)){
					return lovCode;
				}
				return lovName;
			}
		}
		return lovCode;
	}
	
	
	public String getLov() {
		return lov;
	}


	public void setLov(String lov) {
		this.lov = lov;
	}


	public boolean isTrLovFlag() {
		return trLovFlag;
	}


	public void setTrLovFlag(boolean trLovFlag) {
		this.trLovFlag = trLovFlag;
	}


	public Map<String, String> getLovMap() {
		return lovMap;
	}


	public void setLovMap(Map<String, String> lovMap) {
		this.lovMap = lovMap;
	}


	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getField() {
		return field;
	}
	public void setField(String field) {
		this.field = field;
	}
	public Integer getOrder() {
		return order;
	}
	public void setOrder(Integer order) {
		this.order = order;
	}
	
	public int compareTo(ExportColumn arg0) {
		return this.getOrder().compareTo(arg0.getOrder());
	}
	
	
}
