package com.hand.base.charts.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.charts.dao.mybatis.mapper.GoodsRepeatPurchaseMapper;
import com.hand.base.charts.model.GoodsRepeatPurchase;

@Service
public class GoodsRepeatPurchaseServiceImpl extends BasicServiceImpl<GoodsRepeatPurchase> implements GoodsRepeatPurchaseService {
	
	@Resource
	private GoodsRepeatPurchaseMapper	goodsRepeatPurchaseMapper;
	
	@Override
	public BasicMapper<GoodsRepeatPurchase> getBasicMapper() {
		return goodsRepeatPurchaseMapper;
	}
}
