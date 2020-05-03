package com.hand.base.order.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.order.dao.mybatis.mapper.CancelOrderMapper;
import com.hand.base.order.model.CancelOrder;

@Service
public class CancelOrderServiceImpl extends BasicServiceImpl<CancelOrder> implements CancelOrderService {

	@Autowired
	private CancelOrderMapper cancelOrderMapper;

	@Override
	public BasicMapper<CancelOrder> getBasicMapper() {
		return cancelOrderMapper;
	}

	@Override
	public void confirmCancel(HashMap<String, String> hm) throws Exception {
		cancelOrderMapper.confirmCancel(hm);
	}

	@Override
	public List<CancelOrder> queryByOrderNum(String orderNum) throws Exception {
		return cancelOrderMapper.queryByOrderNum(orderNum);
	}

}
