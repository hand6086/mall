package com.hand.base.order.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.order.dao.mybatis.mapper.OrderMerchantMapper;
import com.hand.base.order.model.OrderMerchant;

@Service
public class OrderMerchantServiceImpl extends BasicServiceImpl<OrderMerchant> implements OrderMerchantService {
	@Autowired
	private OrderMerchantMapper orderMerchantMapper;

	@Override
	public BasicMapper<OrderMerchant> getBasicMapper() {
		return orderMerchantMapper;
	}
	
	@Override
	public int queryorderMerchantCount(OrderMerchant entity) throws Exception {
		return orderMerchantMapper.queryorderMerchantCount(entity);
	}
}
