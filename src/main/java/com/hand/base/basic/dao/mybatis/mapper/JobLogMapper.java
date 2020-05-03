package com.hand.base.basic.dao.mybatis.mapper;

import java.util.List;

import com.hand.base.basic.model.JobLog;
import com.hand.core.basic.query.QueryParams;

public interface JobLogMapper {
	
	
	/**
	 * 查询工作流日志
	 * @param pqs
	 * @throws Exception
	 */
	public List<JobLog> queryJobLogListPage(QueryParams pqs) throws Exception;
}