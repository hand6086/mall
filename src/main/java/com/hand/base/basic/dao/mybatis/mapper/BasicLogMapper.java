package com.hand.base.basic.dao.mybatis.mapper;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.model.BasicLog;

public interface BasicLogMapper extends BasicMapper<BasicLog>{
	
	public int addBasicLog(BasicLog record) throws Exception;
	
	
}