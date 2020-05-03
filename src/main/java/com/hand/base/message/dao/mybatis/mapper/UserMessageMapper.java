package com.hand.base.message.dao.mybatis.mapper;

import java.util.List;

import com.hand.base.message.model.UserMessage;
import com.hand.base.basic.dao.mapper.BasicMapper;

public interface UserMessageMapper extends BasicMapper<UserMessage> {

	public List<UserMessage> queryMyMessagePage(UserMessage userMsg);
	
	/**
	 * 
	 *<p>设置为已读</p>
	 * @author yrf
	 */
	public void readFlagUpdate(UserMessage userMsg);
}
