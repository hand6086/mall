package com.hand.base.charts.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.charts.dao.mybatis.mapper.ActivityPaymentConversionMapper;
import com.hand.base.charts.model.ActivityPaymentConversion;

@Service
public class ActivityPaymentConversionServiceImpl extends BasicServiceImpl<ActivityPaymentConversion> implements ActivityPaymentConversionService {
	
	@Resource
	private ActivityPaymentConversionMapper	activityPaymentConversionMapper;
	
	@Override
	public BasicMapper<ActivityPaymentConversion> getBasicMapper() {
		return activityPaymentConversionMapper;
	}
}
