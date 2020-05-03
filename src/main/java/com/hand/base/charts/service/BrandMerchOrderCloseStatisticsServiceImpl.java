package com.hand.base.charts.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.charts.dao.mybatis.mapper.BrandMerchOrderCloseStatisticsMapper;
import com.hand.base.charts.model.BrandMerchOrderCloseStatistics;

@Service
public class BrandMerchOrderCloseStatisticsServiceImpl extends BasicServiceImpl<BrandMerchOrderCloseStatistics> implements BrandMerchOrderCloseStatisticsService {
	
	@Resource
	private BrandMerchOrderCloseStatisticsMapper	brandMerchOrderCloseStatisticsMapper;
	
	@Override
	public BasicMapper<BrandMerchOrderCloseStatistics> getBasicMapper() {
		return brandMerchOrderCloseStatisticsMapper;
	}
}
