package com.hand.base.promotion.service;

import java.util.List;

import com.hand.base.basic.service.BasicService;
import com.hand.base.promotion.model.Promotion;

public interface PromotionGoodsService extends BasicService<Promotion>{

	List<Promotion> querySeckillManPage(Promotion t) throws Exception;

	int queryByMerchCode(Promotion entity)throws Exception;
	
	/**
	 * 品牌馆查询组合套餐商品及搭配数量
	 * @param entity
	 * @throws Exception
	 */
	public List<Promotion> brandQueryCombinationPromotion(Promotion entity) throws Exception;
	
	/**
	 * 品牌馆 根据商品Id查询单品优惠活动数
	 * @param entity
	 * @throws Exception
	 */
	public int brandQueryByMerchId(Promotion entity) throws Exception;
}
