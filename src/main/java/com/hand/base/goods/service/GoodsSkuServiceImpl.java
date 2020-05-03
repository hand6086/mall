package com.hand.base.goods.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.goods.dao.mybatis.mapper.GoodsSkuMapper;
import com.hand.base.goods.model.Goods;

@Service
public class GoodsSkuServiceImpl extends BasicServiceImpl<Goods>implements GoodsSkuService {

	@Autowired
	private GoodsSkuMapper goodsSkuMapper;
	
	@Override
	public BasicMapper<Goods> getBasicMapper(){
		return goodsSkuMapper;
	}

}
