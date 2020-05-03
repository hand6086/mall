package com.hand.base.o2oaccnt.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.o2oaccnt.dao.mybatis.mapper.RestaurantMapper;
import com.hand.base.o2oaccnt.model.Restaurant;

@Service
public class RestaurantServiceImpl extends BasicServiceImpl<Restaurant> implements RestaurantService {
	@Autowired
	private RestaurantMapper restaurantMapper;

	@Override
	public BasicMapper<Restaurant> getBasicMapper() {
		return restaurantMapper;
	}

}
