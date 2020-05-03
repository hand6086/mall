package com.hand.base.charts.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.charts.dao.mybatis.mapper.OperatingSystemReportMapper;
import com.hand.base.charts.model.OperatingSystemReport;
@Service
public class OperatingSystemReportServiceImpl extends BasicServiceImpl<OperatingSystemReport> implements OperatingSystemReportService {
	@Resource
	private OperatingSystemReportMapper	opSystemReportMapper;
	@Override
	public BasicMapper<OperatingSystemReport> getBasicMapper() {
		return opSystemReportMapper;
	}
}
