package com.hand.base.charts.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.charts.dao.mybatis.mapper.MerchPaymentConversionMapper;
import com.hand.base.charts.model.MerchPaymentConversion;

@Service
public class MerchPaymentConversionServiceImpl extends BasicServiceImpl<MerchPaymentConversion> implements MerchPaymentConversionService {
	
	@Resource
	private MerchPaymentConversionMapper merchPaymentConversionMapper;
	
	@Override
	public BasicMapper<MerchPaymentConversion> getBasicMapper() {
		return merchPaymentConversionMapper;
	}
}
