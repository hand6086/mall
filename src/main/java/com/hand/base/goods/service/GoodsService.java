package com.hand.base.goods.service;

import com.hand.base.goods.model.Goods;

import java.util.List;

import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.common.model.Image;


public interface GoodsService extends BasicService<Goods> {
	
	
	/**
	 * 添加产品图片
	 * @param list
	 * @throws BasicServiceException
	 */
	public void goodsShareUpdate(Goods record, List<Image> list) throws BasicServiceException;
	
	/**
	 * 商品详情更新产品图片
	 * @param list
	 * @throws BasicServiceException
	 */
	public void goodsImageUpdate(Goods record, List<Image> list) throws BasicServiceException;
	
	public List<Goods> queryProdCodeByPage(Goods entity) throws Exception;
	
	public Goods queryDetailById(Goods entity) throws Exception;
	
	/**
	 * 查询单位下来列表
	 * @param entity
	 * @return
	 * @throws Exception
	 */
	public List<Goods> queryUnit(Goods entity) throws Exception;

	/**
	 * 更新商品form表单 详情 
	 * @param entity
	 * @throws Exception
	 */
	public void detailUpdate(Goods entity) throws Exception;
	
	/**
	 * 更改产品系列字段为“产品组合”，更改套装商品Flag=Y
	 * @param entity
	 * @throws Exception
	 */
	public void saveAsSuitGoods(Goods entity) throws Exception;

}
