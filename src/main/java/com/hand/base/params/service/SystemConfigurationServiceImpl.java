package com.hand.base.params.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.params.dao.mybatis.mapper.SystemConfigurationMapper;
import com.hand.base.params.model.SystemConfiguration;

@Service
public class SystemConfigurationServiceImpl extends BasicServiceImpl<SystemConfiguration> implements SystemConfigurationService {
	@Autowired
	private SystemConfigurationMapper systemConfigurationMapper;

	@Override
	public BasicMapper<SystemConfiguration> getBasicMapper() {
		return systemConfigurationMapper;
	}

}
