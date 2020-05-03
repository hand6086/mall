package com.hand.base.charts.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.charts.dao.mybatis.mapper.ActivityBrowsingAnalysisMapper;
import com.hand.base.charts.model.ChartsBrowsingAnalysis;

@Service
public class ActivityBrowsingAnalysisServiceImpl extends BasicServiceImpl<ChartsBrowsingAnalysis> implements ActivityBrowsingAnalysisService {
	
	@Resource
	private ActivityBrowsingAnalysisMapper	activityBrowsingAnalysisMapper;
	
	@Override
	public BasicMapper<ChartsBrowsingAnalysis> getBasicMapper() {
		return activityBrowsingAnalysisMapper;
	}
	@Override
	public List<ChartsBrowsingAnalysis> queryByExamplePage(ChartsBrowsingAnalysis entity) throws Exception {
		beforQueryExample(entity);
		beforQueryAllOrExample(entity);
		if("快购".equals(entity.getChooseType())){
			return activityBrowsingAnalysisMapper.queryByExamplePage(entity);
		}else{
			return activityBrowsingAnalysisMapper.brandQueryByExamplePage(entity);
		}
		
	}
}