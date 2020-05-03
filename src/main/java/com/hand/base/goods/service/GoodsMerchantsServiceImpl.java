package com.hand.base.goods.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.goods.dao.mybatis.mapper.GoodsMerchantsMapper;
import com.hand.base.goods.model.GoodsPrice;

@Service
public class GoodsMerchantsServiceImpl extends BasicServiceImpl<GoodsPrice> implements GoodsMerchantsService {

	@Autowired
	private GoodsMerchantsMapper goodsMerchantsMapper;
	
	@Override
	public BasicMapper<GoodsPrice> getBasicMapper(){
		return goodsMerchantsMapper;
	}
}
