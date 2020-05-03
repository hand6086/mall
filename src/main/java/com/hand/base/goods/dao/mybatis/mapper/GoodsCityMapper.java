package com.hand.base.goods.dao.mybatis.mapper;

import java.util.List;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.goods.model.GoodsSeriesCity;

public interface GoodsCityMapper extends BasicMapper<GoodsSeriesCity>{
	
	public List<GoodsSeriesCity> queryCityPKByPage(GoodsSeriesCity entity) throws Exception;
	
}