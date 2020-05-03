package com.hand.base.goods.dao.mybatis.mapper;

import java.util.List;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.goods.model.GoodsSeries;

public interface GoodsSeriesMapper extends BasicMapper<GoodsSeries>{
	
	/**
	 * 添加产品图片
	 * @param record
	 * @throws Exception
	 */
	public void goodsSeriesImageUpdate(GoodsSeries record) throws Exception;
	
	public List<GoodsSeries> queryByPkAll(GoodsSeries entity) throws Exception;
}