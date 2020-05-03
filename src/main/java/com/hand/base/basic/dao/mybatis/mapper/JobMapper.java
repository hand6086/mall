package com.hand.base.basic.dao.mybatis.mapper;

import java.util.List;

import com.hand.base.basic.model.Job;
import com.hand.base.basic.model.JobLog;
import com.hand.core.basic.query.QueryParams;

public interface JobMapper {
	
	public void addJobLog(JobLog record) throws Exception;
	
	/**
	 * 查询所有工作流
	 * @param pqs
	 * @throws Exception
	 */
	public List<Job> queryAllJobListPage(QueryParams pqs) throws Exception;
}