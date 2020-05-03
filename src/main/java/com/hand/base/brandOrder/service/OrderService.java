package com.hand.base.brandOrder.service;


import java.util.List;

import com.hand.base.basic.service.BasicService;
import com.hand.base.brandOrder.model.Order;

public interface OrderService extends BasicService<Order>{
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
