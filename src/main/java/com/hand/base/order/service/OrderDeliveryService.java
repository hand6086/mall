package com.hand.base.order.service;

import com.hand.base.basic.model.CallParam;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.order.model.OrderDelivery;

public interface OrderDeliveryService extends BasicService<OrderDelivery> {


	/**
	 * 检验订单字段是否有效正确
	 * @throws BasicServiceException
	 */
	public void runOrderCheck(CallParam record) throws Exception;
	
	/**
	 * 导入有效字段
	 * @throws BasicServiceException
	 */
	public void runOrderImport(CallParam record) throws Exception;
	
	public void logisticsUpdate(OrderDelivery entity) throws Exception;
	
	public OrderDelivery queryOrderId(OrderDelivery entity) throws Exception;
}
