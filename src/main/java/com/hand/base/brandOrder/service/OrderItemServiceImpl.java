package com.hand.base.brandOrder.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.brandOrder.dao.mybatis.mapper.OrderItemMapper;
import com.hand.base.brandOrder.model.OrderItem;


	@Service
	public class OrderItemServiceImpl  extends BasicServiceImpl<OrderItem>implements OrderItemService {

	@Resource
	private OrderItemMapper	orderItemMapper;
	@Override
	public BasicMapper<OrderItem> getBasicMapper() {
		return orderItemMapper;
	}
}
