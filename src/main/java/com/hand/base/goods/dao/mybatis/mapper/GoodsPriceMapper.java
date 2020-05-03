package com.hand.base.goods.dao.mybatis.mapper;

import java.util.List;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.goods.model.GoodsPrice;

public interface GoodsPriceMapper extends BasicMapper<GoodsPrice>{
	
	public List<GoodsPrice> queryMerchandisePage(GoodsPrice entity) throws Exception;
	
	/**
	 * 品牌馆 商品picklist
	 * @param entity
	 * @return
	 * @throws Exception
	 */
	public List<GoodsPrice> brandQueryMerchandisePage(GoodsPrice entity) throws Exception;
	
	public List<GoodsPrice> queryAccountPage(GoodsPrice entity) throws Exception;
	
	/**
	 * 批量新建商品海报图片
	 * @param entity
	 */
	public void insertPic(GoodsPrice entity) throws Exception;
	
	/**
	 * 查询所有商品海报图片
	 * @param entity
	 */
	public List<GoodsPrice> queryPosterPicAll(GoodsPrice entity) throws Exception;
	
	/**
	 * 删除商品海报图片
	 * @param entity
	 */
	public void deletePicById(GoodsPrice entity) throws Exception;
	
	public int countByCityIdAndName(GoodsPrice entity) throws Exception;
	
}