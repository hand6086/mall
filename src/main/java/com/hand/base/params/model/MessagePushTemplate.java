package com.hand.base.params.model;

import com.hand.base.basic.model.BasicModel;

/**
 * O2O参数设置-消息推送模板
 *
 */
public class MessagePushTemplate extends BasicModel {
	private String tAttr01;// 短信类型
	private String msgContext;// 短信内容

	public MessagePushTemplate() {
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

}
