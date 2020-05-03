package com.hand.base.charts.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.charts.dao.mybatis.mapper.BrandMerchOrderPaymentStatisticsMapper;
import com.hand.base.charts.model.BrandMerchOrderPaymentStatistics;

@Service
public class BrandMerchOrderPaymentStatisticsServiceImpl extends BasicServiceImpl<BrandMerchOrderPaymentStatistics> implements BrandMerchOrderPaymentStatisticsService {
	
	@Resource
	private BrandMerchOrderPaymentStatisticsMapper	brandMerchOrderPaymentStatisticsMapper;
	
	@Override
	public BasicMapper<BrandMerchOrderPaymentStatistics> getBasicMapper() {
		return brandMerchOrderPaymentStatisticsMapper;
	}
}
