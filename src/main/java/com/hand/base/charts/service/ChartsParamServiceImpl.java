package com.hand.base.charts.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import com.hand.base.charts.dao.mybatis.mapper.ChartsParamMapper;
import com.hand.base.charts.model.ChartsParam;
import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;


	@Service
	public class ChartsParamServiceImpl  extends BasicServiceImpl<ChartsParam>implements ChartsParamService {

	@Resource
	private ChartsParamMapper chartsParamMapper;
	@Override
	public BasicMapper<ChartsParam> getBasicMapper() {
		return chartsParamMapper;
	}
	@Override
	public void batchInsertChartsParam(List<ChartsParam> list) throws Exception {
		chartsParamMapper.batchInsertChartsParam(list);
	}
	@Override
	public void historyDelete(Map<String, String> param)throws Exception {
		chartsParamMapper.historyDelete(param);
	}
	
}
