package com.hand.base.order.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.order.dao.mybatis.mapper.OrderSingleProductMapper;
import com.hand.base.order.model.OrderSingleProduct;

@Service
public class OrderSingleProductServiceImpl extends BasicServiceImpl<OrderSingleProduct> implements OrderSingleProductService {
	@Autowired
	private OrderSingleProductMapper orderSingleProductMapper;

	@Override
	public BasicMapper<OrderSingleProduct> getBasicMapper() {
		return orderSingleProductMapper;
	}
	
	@Override
	public int queryorderSingleProductCount(OrderSingleProduct entity) throws Exception {
		return orderSingleProductMapper.queryorderSingleProductCount(entity);
	}

}
