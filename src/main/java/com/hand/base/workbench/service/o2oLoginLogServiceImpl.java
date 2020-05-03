package com.hand.base.workbench.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.workbench.dao.mybatis.mapper.o2oLoginLogMapper;
import com.hand.base.workbench.model.o2oLoginLog;

@Service
public class o2oLoginLogServiceImpl extends BasicServiceImpl<o2oLoginLog>implements o2oLoginLogService {

	@Autowired
	private o2oLoginLogMapper o2oLoginLogMapper;
	
	@Override
	public BasicMapper<o2oLoginLog> getBasicMapper(){
		return o2oLoginLogMapper;
	}
	
	
}
