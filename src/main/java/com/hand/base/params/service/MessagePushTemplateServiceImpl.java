package com.hand.base.params.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.params.dao.mybatis.mapper.MessagePushTemplateMapper;
import com.hand.base.params.model.MessagePushTemplate;

@Service
public class MessagePushTemplateServiceImpl extends BasicServiceImpl<MessagePushTemplate> implements MessagePushTemplateService {
	@Autowired
	private MessagePushTemplateMapper messagePushTemplateMapper;

	@Override
	public BasicMapper<MessagePushTemplate> getBasicMapper() {
		return messagePushTemplateMapper;
	}

}
