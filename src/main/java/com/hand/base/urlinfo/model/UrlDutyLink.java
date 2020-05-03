package com.hand.base.urlinfo.model;

import com.hand.base.basic.model.BasicModel;

public class UrlDutyLink extends BasicModel{

	private String urlId;              	/*urlId*/
	private String dutyId;             	/*dutyId*/
	private String dutyComments;       	/*职责备注*/
	private String dutyName;           	/*职责*/
	private String url;                	/*url*/
	private String urlComments;        	/*url 备注*/
	private String insertFlag;         	/*添加*/
	private String delFlag;            	/*删除*/
	private String updateFlag;         	/*修改*/
	private String selectFlag;         	/*查询*/
	private String defaultAccessFlag;  	/*默认可访问*/
	
	private String accessFlag; /*可访问标记 */
	
	

	public String getAccessFlag() {
		return accessFlag;
	}
	public void setAccessFlag(String accessFlag) {
		this.accessFlag = accessFlag;
	}
	public String getInsertFlag() {
		return insertFlag;
	}
	public void setInsertFlag(String insertFlag) {
		this.insertFlag = insertFlag;
	}
	public String getDelFlag() {
		return delFlag;
	}
	public void setDelFlag(String delFlag) {
		this.delFlag = delFlag;
	}
	public String getUpdateFlag() {
		return updateFlag;
	}
	public void setUpdateFlag(String updateFlag) {
		this.updateFlag = updateFlag;
	}
	public String getSelectFlag() {
		return selectFlag;
	}
	public void setSelectFlag(String selectFlag) {
		this.selectFlag = selectFlag;
	}
	public String getDefaultAccessFlag() {
		return defaultAccessFlag;
	}
	public void setDefaultAccessFlag(String defaultAccessFlag) {
		this.defaultAccessFlag = defaultAccessFlag;
	}
	public String getUrlId() {
		return urlId;
	}
	public void setUrlId(String urlId) {
		this.urlId = urlId;
	}

	public String getDutyId() {
		return dutyId;
	}
	public void setDutyId(String dutyId) {
		this.dutyId = dutyId;
	}

	public String getDutyComments() {
		return dutyComments;
	}
	public void setDutyComments(String dutyComments) {
		this.dutyComments = dutyComments;
	}

	public String getDutyName() {
		return dutyName;
	}
	public void setDutyName(String dutyName) {
		this.dutyName = dutyName;
	}

	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}

	public String getUrlComments() {
		return urlComments;
	}
	public void setUrlComments(String urlComments) {
		this.urlComments = urlComments;
	}



}
