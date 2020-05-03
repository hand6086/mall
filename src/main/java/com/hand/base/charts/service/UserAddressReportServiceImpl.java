package com.hand.base.charts.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.charts.dao.mybatis.mapper.UserAddressReportMapper;
import com.hand.base.charts.model.UserAddressReport;

@Service
public class UserAddressReportServiceImpl extends BasicServiceImpl<UserAddressReport> implements UserAddressReportService  {
	@Resource
	private UserAddressReportMapper	userAddressReportMapper;
	@Override
	public BasicMapper<UserAddressReport> getBasicMapper() {
		return userAddressReportMapper;
	}
}
