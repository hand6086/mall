package com.hand.base.order.dao.mybatis.mapper;

import java.util.List;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.model.ListOfValue;
import com.hand.base.order.model.ShoppingCart;

public interface ShoppingCartMapper extends BasicMapper<ShoppingCart> {
	public List<ShoppingCart> queryCustomerPage(ShoppingCart shoppingCart) throws Exception;

	public List<ShoppingCart> queryMerchantPage(ShoppingCart shoppingCart) throws Exception;
	
	public List<ListOfValue> campaignType(ListOfValue listOfValue) throws Exception;
}
