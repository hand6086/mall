package com.hand.base.charts.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.charts.dao.mybatis.mapper.PlatformBrandMerchSkuDataStatisticsMapper;
import com.hand.base.charts.model.PlatformBrandMerchSkuDataStatistics;

@Service
public class PlatformBrandMerchSkuDataStatisticsServiceImpl extends BasicServiceImpl<PlatformBrandMerchSkuDataStatistics> implements PlatformBrandMerchSkuDataStatisticsService {
	
	@Resource
	private PlatformBrandMerchSkuDataStatisticsMapper platformBrandMerchSkuDataStatisticsMapper;
	
	@Override
	public BasicMapper<PlatformBrandMerchSkuDataStatistics> getBasicMapper() {
		return platformBrandMerchSkuDataStatisticsMapper;
	}
}
