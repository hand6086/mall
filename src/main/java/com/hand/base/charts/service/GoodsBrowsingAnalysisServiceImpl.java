package com.hand.base.charts.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.charts.dao.mybatis.mapper.GoodsBrowsingAnalysisMapper;
import com.hand.base.charts.model.ChartsBrowsingAnalysis;

@Service
public class GoodsBrowsingAnalysisServiceImpl extends BasicServiceImpl<ChartsBrowsingAnalysis> implements GoodsBrowsingAnalysisService {
	
	@Resource
	private GoodsBrowsingAnalysisMapper	goodsBrowsingAnalysisMapper;
	
	@Override
	public BasicMapper<ChartsBrowsingAnalysis> getBasicMapper() {
		return goodsBrowsingAnalysisMapper;
	}
	
	@Override
	public List<ChartsBrowsingAnalysis> queryByExamplePage(ChartsBrowsingAnalysis entity) throws Exception {
		beforQueryExample(entity);
		beforQueryAllOrExample(entity);
		if("快购".equals(entity.getChooseType())){
			return goodsBrowsingAnalysisMapper.queryByExamplePage(entity);
		}else{
			return goodsBrowsingAnalysisMapper.brandQueryByExamplePage(entity);
		}
		
	}
}
