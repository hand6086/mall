package com.hand.base.charts.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.charts.dao.mybatis.mapper.PlatformBrandMerchDataStatisticsMapper;
import com.hand.base.charts.model.PlatformBrandMerchDataStatistics;

@Service
public class PlatformBrandMerchDataStatisticsServiceImpl extends BasicServiceImpl<PlatformBrandMerchDataStatistics> implements PlatformBrandMerchDataStatisticsService {
	
	@Resource
	private PlatformBrandMerchDataStatisticsMapper platformBrandMerchDataStatisticsMapper;
	
	@Override
	public BasicMapper<PlatformBrandMerchDataStatistics> getBasicMapper() {
		return platformBrandMerchDataStatisticsMapper;
	}
}
