package com.hand.base.params.model;

import com.hand.base.basic.model.BasicModel;

/**
 * O2O参数设置-短信模板
 *
 */
public class SmsTemplate extends BasicModel {
	private String tAttr01;// 短信类型
	private String msgContext;// 短信内容
	private String tAttr03;// 容联云模板ID

	public SmsTemplate() {
		super();
	}

	public String gettAttr01() {
		return tAttr01;
	}

	public void settAttr01(String tAttr01) {
		this.tAttr01 = tAttr01;
	}

	public String getMsgContext() {
		return msgContext;
	}

	public void setMsgContext(String msgContext) {
		this.msgContext = msgContext;
	}

	public String gettAttr03() {
		return tAttr03;
	}

	public void settAttr03(String tAttr03) {
		this.tAttr03 = tAttr03;
	}

}
