package com.hand.core.basic.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mybatis.mapper.JobMapper;
import com.hand.base.basic.model.Job;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.basic.service.JobService;
import com.hand.core.basic.query.QueryParams;

@Service
public class JobServiceImpl implements JobService{

	@Autowired
	private JobMapper jobMapper;

	
	public List<Job> queryAllJobListPage(QueryParams qps) throws BasicServiceException {
		List<Job> list = null;
		try {
			list = jobMapper.queryAllJobListPage(qps);
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
		return list;
	}

	

}
