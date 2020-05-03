package com.hand.base.order.dao.mybatis.mapper;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.model.CallParam;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.order.model.OrderDelivery;

public interface OrderDeliveryMapper extends BasicMapper<OrderDelivery>{

	/**
	 * 检验订单字段是否有效正确
	 * @throws BasicServiceException
	 */
	public void runOrderCheck(CallParam record) throws Exception;
	/**
	 * 导入订单
	 * @throws BasicServiceException
	 */
	public void runOrderImport(CallParam record) throws Exception;
	
	public void logisticsUpdate(OrderDelivery entity) throws Exception;
	
	public void orderUpdate(OrderDelivery entity) throws Exception;
	
	public void deleteByArray(OrderDelivery entity) throws Exception;
	
	public OrderDelivery queryOrderId(OrderDelivery entity) throws Exception;
}
