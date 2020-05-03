package com.hand.base.charts.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.charts.dao.mybatis.mapper.BrandMerchAfterSalesAnalysisMapper;
import com.hand.base.charts.model.BrandMerchAfterSalesAnalysis;

@Service
public class BrandMerchAfterSalesAnalysisServiceImpl extends BasicServiceImpl<BrandMerchAfterSalesAnalysis> implements BrandMerchAfterSalesAnalysisService {
	
	@Resource
	private BrandMerchAfterSalesAnalysisMapper brandMerchAfterSalesAnalysisMapper;
	
	@Override
	public BasicMapper<BrandMerchAfterSalesAnalysis> getBasicMapper() {
		return brandMerchAfterSalesAnalysisMapper;
	}
}
