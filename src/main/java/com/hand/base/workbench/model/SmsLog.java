package com.hand.base.workbench.model;

import com.hand.base.basic.model.BasicModel;

/**
 * 短信发送-号码导入
 * @author wangyan
 *
 */
public class SmsLog  extends BasicModel{
	
	private String targetPhone;			
	private String context;	
	private String expireTime;			
	private String type;
	public String getTargetPhone() {
		return targetPhone;
	}
	public void setTargetPhone(String targetPhone) {
		this.targetPhone = targetPhone;
	}
	public String getContext() {
		return context;
	}
	public void setContext(String context) {
		this.context = context;
	}
	public String getExpireTime() {
		return expireTime;
	}
	public void setExpireTime(String expireTime) {
		this.expireTime = expireTime;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	
	
}
