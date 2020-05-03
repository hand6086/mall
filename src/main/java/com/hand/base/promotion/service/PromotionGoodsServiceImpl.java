package com.hand.base.promotion.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.promotion.dao.mybatis.mapper.PromotionGoodsMapper;
import com.hand.base.promotion.model.Promotion;

	
	@Service
	public class PromotionGoodsServiceImpl  extends BasicServiceImpl<Promotion>implements PromotionGoodsService {

	@Resource
	private PromotionGoodsMapper	promotionGoodsMapper;
	@Override
	public BasicMapper<Promotion> getBasicMapper() {
		return promotionGoodsMapper;
	}
	@Override
	public List<Promotion> querySeckillManPage(Promotion t) throws Exception {
		// TODO Auto-generated method stub
		return promotionGoodsMapper.querySeckillManPage(t);
	}
	@Override
	public int queryByMerchCode(Promotion entity) throws Exception {
		// TODO Auto-generated method stub
		return promotionGoodsMapper.queryByMerchCode(entity);
	}
	@Override
	public List<Promotion> brandQueryCombinationPromotion(Promotion entity) throws Exception {
		return promotionGoodsMapper.brandQueryCombinationPromotion(entity);
	}
	@Override
	public int brandQueryByMerchId(Promotion entity) throws Exception {
		return promotionGoodsMapper.brandQueryByMerchId(entity);
	}
}
