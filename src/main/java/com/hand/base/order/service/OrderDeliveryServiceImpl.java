package com.hand.base.order.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.model.CallParam;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.order.dao.mybatis.mapper.OrderDeliveryMapper;
import com.hand.base.order.model.OrderDelivery;
import com.hand.base.user.model.User;
import com.hand.core.util.UserUtil;

@Service
public class OrderDeliveryServiceImpl extends BasicServiceImpl<OrderDelivery> implements OrderDeliveryService {
	@Autowired
	private OrderDeliveryMapper orderDeliveryMapper;

	@Override
	public BasicMapper<OrderDelivery> getBasicMapper() {
		return orderDeliveryMapper;
	}
	
	@Override
	public void beforQueryExample(OrderDelivery entity) throws Exception{
		User user = UserUtil.getUser(null);
		entity.setCreatedBy(user.getId());
	}
	
	
	@Transactional
	public void runOrderCheck(CallParam record) throws BasicServiceException {
		try {
			User user = UserUtil.getUser(null);
			record.setParam1(user.getId());
			orderDeliveryMapper.runOrderCheck(record);
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
	}
	
	@Transactional
	public void runOrderImport(CallParam record) throws BasicServiceException {
		try {
			User user = UserUtil.getUser(null);
			record.setParam1(user.getId());
			orderDeliveryMapper.runOrderImport(record);
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
	}
	
	@Transactional
	public void logisticsUpdate(OrderDelivery entity) throws Exception{
		if(!checkData(entity)){//进行数据校验
			throw new BasicServiceException("校验不通过，请检查数据！");
		}

		orderDeliveryMapper.logisticsUpdate(entity);
		entity.setAttrib48("To_Receive");
		entity.setAttrib07("Delivered");
		orderDeliveryMapper.orderUpdate(entity);
		
		orderDeliveryMapper.deleteByArray(entity);
	}
	
	public OrderDelivery queryOrderId(OrderDelivery entity) throws Exception{
		return orderDeliveryMapper.queryOrderId(entity);
	}
}
