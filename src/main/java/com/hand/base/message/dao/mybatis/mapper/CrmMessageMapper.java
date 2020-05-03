package com.hand.base.message.dao.mybatis.mapper;

import java.util.List;

import com.hand.base.message.model.CrmMessage;
import com.hand.base.message.model.UserMessage;
import com.hand.base.user.model.User;
import com.hand.base.basic.dao.mapper.BasicMapper;

public interface CrmMessageMapper extends BasicMapper<CrmMessage> {

	/**
	 * 查询未在消息发送列表里的用户
	 * @param qps
	 * @return
	 */
	public List<User> queryUnSelectUserListPage(UserMessage userMsg);
	/**
	 * 
	 *<p>插入消息到移动端推送表</p>
	 * @author yrf
	 * @param userMsg
	 */
	public void mobileMsgInsert(UserMessage userMsg);
}
