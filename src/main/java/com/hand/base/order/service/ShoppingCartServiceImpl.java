package com.hand.base.order.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.model.ListOfValue;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.order.dao.mybatis.mapper.ShoppingCartMapper;
import com.hand.base.order.model.ShoppingCart;

@Service
public class ShoppingCartServiceImpl extends BasicServiceImpl<ShoppingCart> implements ShoppingCartService {
	@Autowired
	private ShoppingCartMapper shoppingCartMapper;

	@Override
	public BasicMapper<ShoppingCart> getBasicMapper() {
		return shoppingCartMapper;
	}

	@Override
	public List<ShoppingCart> queryCustomerPage(ShoppingCart shoppingCart) throws Exception {
		return shoppingCartMapper.queryCustomerPage(shoppingCart);
	}

	@Override
	public List<ShoppingCart> queryMerchantPage(ShoppingCart shoppingCart) throws Exception {
		return shoppingCartMapper.queryMerchantPage(shoppingCart);
	}
	
	public List<ListOfValue> campaignType(ListOfValue listOfValue) throws Exception {
		return shoppingCartMapper.campaignType(listOfValue);
	}
}
