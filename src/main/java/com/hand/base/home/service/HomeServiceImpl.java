package com.hand.base.home.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.home.dao.mybatis.mapper.HomeMapper;
import com.hand.base.user.model.User;
import com.hand.core.util.UserUtil;

@Service
public class HomeServiceImpl implements HomeService{
	
	@Autowired
	private HomeMapper homeMapper;
	

	@Override
	public String queryProductCurentWeekCount() throws Exception {
		User user = UserUtil.getUser(null);
		return homeMapper.queryProductCurentWeekCount(user);
	}

	@Override
	public String queryOrderCurentWeekCount() throws Exception {
		User user = UserUtil.getUser(null);
		return homeMapper.queryOrderCurentWeekCount(user);
	}

	@Override
	public String querySaleCurentWeekCount() throws Exception {
		User user = UserUtil.getUser(null);
		return homeMapper.querySaleCurentWeekCount(user);
	}

	@Override
	public String queryProductSaleCurentWeekCount() throws Exception {
		User user = UserUtil.getUser(null);
		return homeMapper.queryProductSaleCurentWeekCount(user);
	}
}
