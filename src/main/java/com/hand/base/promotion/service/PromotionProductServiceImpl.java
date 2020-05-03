package com.hand.base.promotion.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.promotion.dao.mybatis.mapper.PromotionProductMapper;
import com.hand.base.promotion.model.PromotionProduct;


@Service
public class PromotionProductServiceImpl extends BasicServiceImpl<PromotionProduct> implements PromotionProductService {
	@Autowired
	private PromotionProductMapper promotionProductMapper;
	
	@Override
	public BasicMapper<PromotionProduct> getBasicMapper(){
		return promotionProductMapper;
	}

}
