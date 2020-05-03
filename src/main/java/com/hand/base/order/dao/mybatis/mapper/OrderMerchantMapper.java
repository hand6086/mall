package com.hand.base.order.dao.mybatis.mapper;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.order.model.OrderMerchant;

public interface OrderMerchantMapper extends BasicMapper<OrderMerchant>{
	public int queryorderMerchantCount(OrderMerchant entity) throws Exception;
}
