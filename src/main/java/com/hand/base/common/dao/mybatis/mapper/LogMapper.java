package com.hand.base.common.dao.mybatis.mapper;

import com.hand.base.common.model.Log;

public interface LogMapper {
    
	//public List<Map> queryLogPage(String loginId) throws Exception;
	
	public void logInsert(Log log) throws Exception;
	
	public void logUpdate(Log log) throws Exception;
	
	public void logDelete(Log log) throws Exception;
}