package com.hand.base.order.service;

import com.hand.base.basic.service.BasicService;
import com.hand.base.order.model.OrderSingleProduct;

public interface OrderSingleProductService extends BasicService<OrderSingleProduct> {
	public int queryorderSingleProductCount(OrderSingleProduct entity) throws Exception;
}
