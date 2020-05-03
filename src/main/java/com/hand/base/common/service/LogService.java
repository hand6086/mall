package com.hand.base.common.service;

import java.util.List;

import com.hand.base.common.model.Log;

public interface LogService {
	
	public List<Log> queryLogs(String loginId) throws Exception;
	
	public void addLog(Log log) throws Exception;

}
