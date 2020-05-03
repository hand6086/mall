package com.hand.base.promotion.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.promotion.dao.mybatis.mapper.SalesPromotionSchemaMapper;
import com.hand.base.promotion.model.SalesPromotionSchema;


@Service
public class SalesPromotionSchemaServiceImpl extends BasicServiceImpl<SalesPromotionSchema> implements SalesPromotionSchemaService {
	@Autowired
	private SalesPromotionSchemaMapper salesPromotionSchemaMapper;
	
	@Override
	public BasicMapper<SalesPromotionSchema> getBasicMapper(){
		return salesPromotionSchemaMapper;
	}
}
