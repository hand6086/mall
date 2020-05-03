package com.hand.base.o2odataimport.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.model.CallParam;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.o2odataimport.dao.mybatis.mapper.RestaurantImpMapper;
import com.hand.base.o2odataimport.model.RestaurantTemp;
import com.hand.base.user.model.User;
import com.hand.core.util.UserUtil;
@Service
public class RestaurantImpServiceImpl extends BasicServiceImpl<RestaurantTemp> implements RestaurantImpService{
	@Autowired
	private RestaurantImpMapper restaurantImpMapper;
	
	public BasicMapper<RestaurantTemp> getBasicMapper(){
		return restaurantImpMapper;
	}
	
	@Transactional
	public void runRestaurantCheck(CallParam record) throws BasicServiceException {
		try {
			User user = UserUtil.getUser(null);
			record.setParam1(user.getId());
			restaurantImpMapper.runRestaurantCheck(record);
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
	}
	
	@Transactional
	public void runRestaurantImp(CallParam record) throws BasicServiceException {
		try {
			User user = UserUtil.getUser(null);
			record.setParam1(user.getId());
			restaurantImpMapper.runRestaurantImp(record);
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
	}
}
