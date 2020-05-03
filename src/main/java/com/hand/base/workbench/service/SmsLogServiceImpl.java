package com.hand.base.workbench.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.workbench.dao.mybatis.mapper.SmsLogMapper;
import com.hand.base.workbench.model.SmsLog;

@Service
public class SmsLogServiceImpl extends BasicServiceImpl<SmsLog>implements SmsLogService {

	@Autowired
	private SmsLogMapper smsLogMapper;
	
	@Override
	public BasicMapper<SmsLog> getBasicMapper(){
		return smsLogMapper;
	}
	
	
}
