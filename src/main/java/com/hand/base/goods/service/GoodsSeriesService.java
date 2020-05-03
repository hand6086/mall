package com.hand.base.goods.service;

import com.hand.base.goods.model.GoodsSeries;

import java.util.List;

import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.common.model.Image;


public interface GoodsSeriesService extends BasicService<GoodsSeries> {
	
	/**
	 * 添加产品图片
	 * @param list
	 * @throws BasicServiceException
	 */
	public void goodsSeriesImageUpate(GoodsSeries record, List<Image> list) throws BasicServiceException;
	
	public List<GoodsSeries> queryByPkAll(GoodsSeries entity) throws Exception;
}
