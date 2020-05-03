package com.hand.base.brandpromotion.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.brandpromotion.dao.mybatis.mapper.BrandPromotionSchemaMapper;
import com.hand.base.brandpromotion.model.BrandPromotionSchema;


	@Service
	public class BrandPromotionSchemaServiceImpl  extends BasicServiceImpl<BrandPromotionSchema>implements BrandPromotionSchemaService {

	@Resource
	private BrandPromotionSchemaMapper	brandPromotionSchemaMapper;
	@Override
	public BasicMapper<BrandPromotionSchema> getBasicMapper() {
		return brandPromotionSchemaMapper;
	}
}
