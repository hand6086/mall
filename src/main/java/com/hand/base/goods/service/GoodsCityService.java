package com.hand.base.goods.service;

import com.hand.base.goods.model.GoodsSeriesCity;

import java.util.List;

import com.hand.base.basic.service.BasicService;

public interface GoodsCityService extends BasicService<GoodsSeriesCity> {
	
	public List<GoodsSeriesCity> queryCity(GoodsSeriesCity entity) throws Exception;

}
