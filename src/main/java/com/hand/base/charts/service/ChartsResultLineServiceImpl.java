package com.hand.base.charts.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import com.hand.base.charts.dao.mybatis.mapper.ChartsResultLineMapper;
import com.hand.base.charts.model.ChartsResultLine;
import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;


	@Service
	public class ChartsResultLineServiceImpl  extends BasicServiceImpl<ChartsResultLine>implements ChartsResultLineService {

	@Resource
	private BasicMapper<ChartsResultLine>	chartsResultLineMapper;
	@Override
	public BasicMapper<ChartsResultLine> getBasicMapper() {
		return chartsResultLineMapper;
	}
}
