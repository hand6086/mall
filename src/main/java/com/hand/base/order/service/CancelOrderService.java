package com.hand.base.order.service;

import java.util.HashMap;
import java.util.List;

import com.hand.base.basic.service.BasicService;
import com.hand.base.order.model.CancelOrder;

public interface CancelOrderService extends BasicService<CancelOrder> {
	public void confirmCancel(HashMap<String, String> hm) throws Exception;

	public List<CancelOrder> queryByOrderNum(String orderNum) throws Exception;
}
