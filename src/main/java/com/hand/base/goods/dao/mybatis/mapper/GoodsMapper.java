package com.hand.base.goods.dao.mybatis.mapper;

import java.util.List;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.goods.model.Goods;

public interface GoodsMapper extends BasicMapper<Goods>{
	
	/**
	 * 添加产品图片
	 * @param record
	 * @throws Exception
	 */
	public void goodsShareUpdate(Goods record) throws Exception;
	
	/**
	 * 商品详情更新产品图片
	 * @param record
	 * @throws Exception
	 */
	public void goodsImageUpdate(Goods record) throws Exception;
	
	public List<Goods> queryProdCodeByPage(Goods entity) throws Exception;
	
	public void prodIntXInsert(Goods entity) throws Exception;
	
	public void vodInsert(Goods entity) throws Exception;
	
	public void prodIntXUpdate(Goods entity) throws Exception;
	
	public Goods queryDetailById(Goods entity) throws Exception;
	
	/**
	 * 查询单位下来列表
	 * @param entity
	 * @return
	 * @throws Exception
	 */
	public List<Goods> queryUnit(Goods entity) throws Exception;
	
	public void detailUpdate(Goods entity) throws Exception;
	
	public void unitDetailUpdate(Goods entity) throws Exception;
	
	public void saveAsSuitGoods(Goods entity) throws Exception;
	
}