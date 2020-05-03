package com.hand.base.charts.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.charts.dao.mybatis.mapper.BrandMerchGoodsSalesAnalysisMapper;
import com.hand.base.charts.model.BrandMerchGoodsSalesAnalysis;

@Service
public class BrandMerchGoodsSalesAnalysisServiceImpl extends BasicServiceImpl<BrandMerchGoodsSalesAnalysis> implements BrandMerchGoodsSalesAnalysisService {
	
	@Resource
	private BrandMerchGoodsSalesAnalysisMapper brandMerchGoodsSalesAnalysisMapper;
	
	@Override
	public BasicMapper<BrandMerchGoodsSalesAnalysis> getBasicMapper() {
		return brandMerchGoodsSalesAnalysisMapper;
	}
}
