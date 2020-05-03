package com.hand.base.goods.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.goods.dao.mybatis.mapper.GoodsCityMapper;
import com.hand.base.goods.model.GoodsSeriesCity;

@Service
public class GoodsCityServiceImpl extends BasicServiceImpl<GoodsSeriesCity> implements GoodsCityService {

	@Autowired
	private GoodsCityMapper goodsCityMapper;
	
	
	@Override
	public BasicMapper<GoodsSeriesCity> getBasicMapper(){
		return goodsCityMapper;
	}
	
	public List<GoodsSeriesCity> queryCity(GoodsSeriesCity entity) throws Exception{
		return goodsCityMapper.queryCityPKByPage(entity);
	}


}
