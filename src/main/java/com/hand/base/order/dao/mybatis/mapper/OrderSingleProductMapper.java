package com.hand.base.order.dao.mybatis.mapper;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.order.model.OrderSingleProduct;

public interface OrderSingleProductMapper extends BasicMapper<OrderSingleProduct>{
	public int queryorderSingleProductCount(OrderSingleProduct entity) throws Exception;
}
