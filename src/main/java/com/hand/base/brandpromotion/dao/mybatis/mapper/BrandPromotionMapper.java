package com.hand.base.brandpromotion.dao.mybatis.mapper;

import java.util.List;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.brandpromotion.model.BrandPromotion;


public interface BrandPromotionMapper extends BasicMapper<BrandPromotion>{
 
	public List<BrandPromotion> campaignParticipantQueryPage(BrandPromotion brandPromotion) throws Exception;
	
	/**
	 * 查询所选 促销方案下的大区
	 * @return
	 * @throws Exception
	 */
	List<BrandPromotion> queryCityPage(BrandPromotion brandPromotion) throws Exception;
	
	/**
	 * 查询活动行  促销类型下拉列表(活动方案)
	 * @throws Exception
	 */
	List<BrandPromotion> queryType(BrandPromotion brandPromotion) throws Exception;
	/**
	 * 查询商品
	 * @throws Exception
	 */
	List<BrandPromotion> querygoods(BrandPromotion brandPromotion) throws Exception;
	
	/**
	 * 根据方案ID修改活动行状态
	 * @param promotion
	 * @return
	 * @throws Exception
	 */
	void batchUpdateStatus(BrandPromotion brandPromotion) throws Exception;
}
