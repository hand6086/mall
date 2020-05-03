package com.hand.base.order.service;

import java.util.List;

import com.hand.base.basic.model.ListOfValue;
import com.hand.base.basic.service.BasicService;
import com.hand.base.order.model.ShoppingCart;

public interface ShoppingCartService extends BasicService<ShoppingCart> {
	public List<ShoppingCart> queryCustomerPage(ShoppingCart shoppingCart) throws Exception;

	public List<ShoppingCart> queryMerchantPage(ShoppingCart shoppingCart) throws Exception;
	
	public List<ListOfValue> campaignType(ListOfValue listOfValue) throws Exception;
}
