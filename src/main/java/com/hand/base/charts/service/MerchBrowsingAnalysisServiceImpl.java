package com.hand.base.charts.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.charts.dao.mybatis.mapper.MerchBrowsingAnalysisMapper;
import com.hand.base.charts.model.ChartsBrowsingAnalysis;

@Service
public class MerchBrowsingAnalysisServiceImpl extends BasicServiceImpl<ChartsBrowsingAnalysis> implements MerchBrowsingAnalysisService {
	
	@Resource
	private MerchBrowsingAnalysisMapper	merchBrowsingAnalysisMapper;
	
	@Override
	public BasicMapper<ChartsBrowsingAnalysis> getBasicMapper() {
		return merchBrowsingAnalysisMapper;
	}
}
