package com.hand.base.goods.service;

import com.hand.base.goods.model.Goods;
import com.hand.base.goods.model.GoodsSuit;

import java.util.List;

import com.hand.base.basic.service.BasicService;


public interface GoodsSuitService extends BasicService<GoodsSuit> {
	
	public List<GoodsSuit> queryOrderPkAll(GoodsSuit entity) throws Exception;
	
	public List<GoodsSuit> queryCustomerPkAll(GoodsSuit entity) throws Exception;
	
	/**
	 * 更改套装商品Flag=N
	 * @param entity
	 * @throws Exception
	 */
	public void saveAsGoods(GoodsSuit entity) throws Exception;
}
