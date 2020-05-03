package com.hand.base.basic.service;

import java.util.List;

import com.hand.base.basic.model.JobLog;
import com.hand.core.basic.query.QueryParams;

public interface JobLogService {
	
	/**
	 * 查询工作流日志
	 * @param qps
	 * @return
	 * @throws BasicServiceException
	 */
	public List<JobLog> queryJobLogListPage(QueryParams qps) throws BasicServiceException;
}
