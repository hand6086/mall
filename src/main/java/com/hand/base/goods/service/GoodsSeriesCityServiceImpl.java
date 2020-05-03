package com.hand.base.goods.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.goods.dao.mybatis.mapper.GoodsSeriesCityMapper;
import com.hand.base.goods.model.GoodsSeriesCity;

@Service
public class GoodsSeriesCityServiceImpl extends BasicServiceImpl<GoodsSeriesCity> implements GoodsSeriesCityService {

	@Autowired
	private GoodsSeriesCityMapper goodsSeriesCityMapper;
	
	
	@Override
	public BasicMapper<GoodsSeriesCity> getBasicMapper(){
		return goodsSeriesCityMapper;
	}

}
