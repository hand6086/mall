package com.hand.base.charts.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.charts.dao.mybatis.mapper.PageStatisticalAnalysisMapper;
import com.hand.base.charts.model.ChartsBrowsingAnalysis;

@Service
public class PageStatisticalAnalysisServiceImpl extends BasicServiceImpl<ChartsBrowsingAnalysis> implements PageStatisticalAnalysisService {
	
	@Resource
	private PageStatisticalAnalysisMapper	pageStatisticalAnalysisMapper;
	
	@Override
	public BasicMapper<ChartsBrowsingAnalysis> getBasicMapper() {
		return pageStatisticalAnalysisMapper;
	}
	
	@Override
	public List<ChartsBrowsingAnalysis> queryByExamplePage(ChartsBrowsingAnalysis entity) throws Exception {
		beforQueryExample(entity);
		beforQueryAllOrExample(entity);
		if("快购".equals(entity.getChooseType())){
			return pageStatisticalAnalysisMapper.queryByExamplePage(entity);
		}else{
			return pageStatisticalAnalysisMapper.brandQueryByExamplePage(entity);
		}
		
	}
}
