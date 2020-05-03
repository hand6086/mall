package com.hand.base.workbench.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.workbench.dao.mybatis.mapper.SmsLineMapper;
import com.hand.base.workbench.model.SmsSend;

@Service
public class SmsLineServiceImpl extends BasicServiceImpl<SmsSend>implements SmsLineService {

	@Autowired
	private SmsLineMapper smsLineMapper;
	
	@Override
	public BasicMapper<SmsSend> getBasicMapper(){
		return smsLineMapper;
	}
	
	
}
