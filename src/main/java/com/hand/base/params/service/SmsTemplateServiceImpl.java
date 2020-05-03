package com.hand.base.params.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.params.dao.mybatis.mapper.SmsTemplateMapper;
import com.hand.base.params.model.SmsTemplate;

@Service
public class SmsTemplateServiceImpl extends BasicServiceImpl<SmsTemplate> implements SmsTemplateService {
	@Autowired
	private SmsTemplateMapper smsTemplateMapper;

	@Override
	public BasicMapper<SmsTemplate> getBasicMapper() {
		return smsTemplateMapper;
	}

}
