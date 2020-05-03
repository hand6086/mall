package com.hand.base.charts.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.charts.dao.mybatis.mapper.LoginFrequencyReportMapper;
import com.hand.base.charts.model.LoginFrequencyReport;
@Service
public class LoginFrequencyReportServiceImpl extends BasicServiceImpl<LoginFrequencyReport> implements LoginFrequencyReportService{
	@Resource
	private LoginFrequencyReportMapper	loginFrequencyMapper;
	@Override
	public BasicMapper<LoginFrequencyReport> getBasicMapper() {
		return loginFrequencyMapper ;
	}
}
