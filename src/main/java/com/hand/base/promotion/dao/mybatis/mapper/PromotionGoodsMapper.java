package com.hand.base.promotion.dao.mybatis.mapper;

import java.util.List;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.promotion.model.Promotion;


public interface PromotionGoodsMapper extends BasicMapper<Promotion>{

	public  List<Promotion> querySeckillManPage(Promotion t) throws Exception;

	public int queryByMerchCode(Promotion entity) throws Exception;
	
	public void timeUpdate(Promotion entity) throws Exception;
	
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
	
	/**
	 * 根据方案ID修改活动行状态和删除标识
	 * @param promotion
	 * @throws Exception
	 */
	void updateStatusBySchemaId(Promotion promotion) throws Exception;
	/**
	 * 根据促销头ID修改活动行状态和删除标识
	 * @param promotion
	 * @throws Exception
	 */
	void updateStatusByHeadId(Promotion promotion) throws Exception;
}
