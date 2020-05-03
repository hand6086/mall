package com.hand.base.message.service;

import java.util.List;

import com.hand.base.message.model.CrmMessage;
import com.hand.base.message.model.UserMessage;
import com.hand.base.user.model.User;
import com.hand.base.basic.service.BasicService;

public interface CrmMessageService extends BasicService<CrmMessage> {

	/**
	 * 查询未在消息发送列表里的用户
	 * @param qps
	 * @return
	 */
	public List<User> queryUnSelectUserListPage(UserMessage userMsg);

	/**
	 * 接收@消息并解析保存
	 * @param msgContent
	 */
	public void atUserMsg(CrmMessage msg);


	public void messageReplyInsert(CrmMessage msg);
}
