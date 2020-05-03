package com.hand.base.message.service;

import java.util.List;

import com.hand.base.message.model.UserMessage;
import com.hand.base.basic.service.BasicService;

public interface UserMessageService extends BasicService<UserMessage> {

	public List<UserMessage> queryMyMessagePage(UserMessage userMsg);
	
	/**
	 * 
	 *<p>设置消息为已读</p>
	 * @author yrf
	 */
	public void readFlagUpdate(UserMessage userMsg);
}
