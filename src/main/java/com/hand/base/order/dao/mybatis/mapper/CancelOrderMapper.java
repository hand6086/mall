package com.hand.base.order.dao.mybatis.mapper;

import java.util.HashMap;
import java.util.List;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.order.model.CancelOrder;

public interface CancelOrderMapper extends BasicMapper<CancelOrder> {
	public void confirmCancel(HashMap<String, String> hm) throws Exception;

	public List<CancelOrder> queryByOrderNum(String orderNum) throws Exception;
}
