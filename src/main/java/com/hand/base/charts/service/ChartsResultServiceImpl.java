package com.hand.base.charts.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import com.hand.base.charts.dao.mybatis.mapper.ChartsResultMapper;
import com.hand.base.charts.model.ChartsResult;
import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;


	@Service
	public class ChartsResultServiceImpl  extends BasicServiceImpl<ChartsResult>implements ChartsResultService {

	@Resource
	private ChartsResultMapper	chartsMapper;
	@Override
	public BasicMapper<ChartsResult> getBasicMapper() {
		return chartsMapper;
	}
}
