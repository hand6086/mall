package com.hand.base.order.service;

import com.hand.base.basic.service.BasicService;
import com.hand.base.order.model.OrderMerchant;

public interface OrderMerchantService extends BasicService<OrderMerchant> {
	public int queryorderMerchantCount(OrderMerchant entity) throws Exception;
}
