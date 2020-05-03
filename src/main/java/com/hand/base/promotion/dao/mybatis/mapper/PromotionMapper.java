package com.hand.base.promotion.dao.mybatis.mapper;

import java.util.List;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.promotion.model.Promotion;


public interface PromotionMapper extends BasicMapper<Promotion>{
	
	/**
	 * 根据方案Id查询方案时间
	 * @param schemaId
	 * @return
	 * @throws Exception
	 */
	Promotion querySchemaTimeBySchemaId(String schemaId) throws Exception;
	
 
	public List<Promotion> campaignParticipantQueryPage(Promotion t)throws Exception;
	
	/**
	 * 查询所选 促销方案下的大区
	 * @return
	 * @throws Exception
	 */
	List<Promotion> queryCityPage(Promotion promotion) throws Exception;
	
	/**
	 * 查询活动行  促销类型下拉列表(活动方案)
	 * @throws Exception
	 */
	List<Promotion> queryType(Promotion promotion) throws Exception;
	
	/**
	 * 查询店铺id及店铺名
	 * @throws Exception
	 */
	public Promotion queryStoreInfoByCode(Promotion promotion) throws Exception;
	
	/**
	 * 查询商品
	 * @throws Exception
	 */
	List<Promotion> querygoods(Promotion promotion) throws Exception;
	
	/**
	 * 根据方案id查询活动记录
	 * @throws Exception
	 */
	public Promotion brandQueryBySchemaId(Promotion promotion) throws Exception;
	
	/**
	 * 根据方案ID修改活动行状态
	 * @param promotion
	 * @return
	 * @throws Exception
	 */
	void batchUpdateStatus(Promotion promotion) throws Exception;
	
	/**
	 * 合计当前时间段是否有店铺活动（品牌馆）
	 * @return
	 * @throws Exception
	 */
	public int brandQueryShopPromotionCount(Promotion promotion) throws Exception;
	
	/**
	 * 特价限购更新方案信息
	 * @param promotion
	 * @throws Exception
	 */
	void updateHead(Promotion promotion) throws Exception;
	
	/**
	 * 根据方案ID修改活动行状态和删除标识
	 * @param promotion
	 * @throws Exception
	 */
	void updateStatusBySchemaId(Promotion promotion) throws Exception;
}
