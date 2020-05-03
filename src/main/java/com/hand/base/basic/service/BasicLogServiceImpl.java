package com.hand.base.basic.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.dao.mybatis.mapper.BasicLogMapper;
import com.hand.base.basic.model.BasicLog;

@Service
public class BasicLogServiceImpl extends BasicServiceImpl<BasicLog> implements BasicLogService{

	@Autowired
	private BasicLogMapper basicLogMapper;
	
	@Override
	public BasicMapper<BasicLog> getBasicMapper(){
		return basicLogMapper;
	}

	@Override
	public int addBasicLog(BasicLog record) throws Exception {
		return basicLogMapper.addBasicLog(record);
	}

	
}
