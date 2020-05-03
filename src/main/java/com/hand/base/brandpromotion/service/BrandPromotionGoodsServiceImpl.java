package com.hand.base.brandpromotion.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.brandpromotion.dao.mybatis.mapper.BrandPromotionGoodsMapper;
import com.hand.base.brandpromotion.model.BrandPromotionGoods;

@Service
public class BrandPromotionGoodsServiceImpl extends BasicServiceImpl<BrandPromotionGoods> implements BrandPromotionGoodsService {

	@Resource
	private BrandPromotionGoodsMapper brandPromotionGoodsMapper;

	@Override
	public BasicMapper<BrandPromotionGoods> getBasicMapper() {
		return brandPromotionGoodsMapper;
	}

}
