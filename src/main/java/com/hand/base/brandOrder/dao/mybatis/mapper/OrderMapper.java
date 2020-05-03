package com.hand.base.brandOrder.dao.mybatis.mapper;


import java.util.List;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.brandOrder.model.Order;

public interface OrderMapper extends BasicMapper<Order>{
	
	/**
	 * 根据品牌馆订单头和行
	 * @param qps
	 * @return
	 */
	public List<Order> batchQueryOrderPage(Order entity) throws Exception;

	/**
	 * 根据品牌馆订单头和行
	 * @param qps
	 * @return
	 */
	public List<Order> batchQueryOrderExportPage(Order entity) throws Exception;
	
}
