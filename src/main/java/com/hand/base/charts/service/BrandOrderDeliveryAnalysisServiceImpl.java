package com.hand.base.charts.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.charts.dao.mybatis.mapper.BrandOrderDeliveryAnalysisMapper;
import com.hand.base.charts.model.BrandOrderDeliveryAnalysis;

@Service
public class BrandOrderDeliveryAnalysisServiceImpl extends BasicServiceImpl<BrandOrderDeliveryAnalysis> implements BrandOrderDeliveryAnalysisService {
	
	@Resource
	private BrandOrderDeliveryAnalysisMapper brandOrderDeliveryAnalysisMapper;
	
	@Override
	public BasicMapper<BrandOrderDeliveryAnalysis> getBasicMapper() {
		return brandOrderDeliveryAnalysisMapper;
	}
}
