package com.hand.base.basic.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mybatis.mapper.JobLogMapper;
import com.hand.base.basic.model.JobLog;
import com.hand.core.basic.query.QueryParams;

@Service
public class JobLogServiceImpl implements JobLogService{

	@Autowired
	private JobLogMapper jobLogMapper;

	
	public List<JobLog> queryJobLogListPage(QueryParams qps) throws BasicServiceException {
		List<JobLog> list = null;
		try {
			list = jobLogMapper.queryJobLogListPage(qps);
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
		return list;
	}

	

}
