package com.hand.base.goods.service;

import java.util.List;

import com.hand.base.basic.service.BasicService;
import com.hand.base.goods.model.GoodsPrice;

public interface GoodsPriceService extends BasicService<GoodsPrice> {
	
	public void insertPic(GoodsPrice entity) throws Exception ;
	
	public List<GoodsPrice> queryMerchandisePage(GoodsPrice entity) throws Exception;
	
	/**
	 * 品牌馆 商品picklist
	 * @param entity
	 * @return
	 * @throws Exception
	 */
	public List<GoodsPrice> brandQueryMerchandisePage(GoodsPrice entity) throws Exception;
	
	public List<GoodsPrice> queryAccountPage(GoodsPrice entity) throws Exception;
	
	public List<GoodsPrice> queryPosterPicAll(GoodsPrice entity) throws Exception;
	
	public int countByCityIdAndName(GoodsPrice entity) throws Exception;
}
