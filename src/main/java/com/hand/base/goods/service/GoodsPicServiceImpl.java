package com.hand.base.goods.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.goods.dao.mybatis.mapper.GoodsPicMapper;
import com.hand.base.goods.model.GoodsSuit;

@Service
public class GoodsPicServiceImpl extends BasicServiceImpl<GoodsSuit>implements GoodsPicService {

	@Autowired
	private GoodsPicMapper goodsPicMapper;
	
	@Override
	public BasicMapper<GoodsSuit> getBasicMapper(){
		return goodsPicMapper;
	}
	
}
