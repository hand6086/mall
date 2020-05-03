package com.hand.base.params.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.params.dao.mybatis.mapper.DistributionRequireMapper;
import com.hand.base.params.model.DistributionRequire;

@Service
public class DistributionRequireServiceImpl extends BasicServiceImpl<DistributionRequire> implements DistributionRequireService {
	@Autowired
	private DistributionRequireMapper distributionRequireMapper;

	@Override
	public BasicMapper<DistributionRequire> getBasicMapper() {
		return distributionRequireMapper;
	}
}
