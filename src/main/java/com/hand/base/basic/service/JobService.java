package com.hand.base.basic.service;

import java.util.List;

import com.hand.base.basic.model.Job;
import com.hand.core.basic.query.QueryParams;

public interface JobService {
	
	/**
	 * 查询所有工作流
	 * @param qps
	 * @return
	 * @throws BasicServiceException
	 */
	public List<Job> queryAllJobListPage(QueryParams qps) throws BasicServiceException;
}
