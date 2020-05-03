package com.hand.base.user.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.user.dao.mybatis.mapper.OnlineUserMapper;
import com.hand.base.user.model.OnlineUser;

@Service
public class OnlineUserServiceImpl extends BasicServiceImpl<OnlineUser> implements OnlineUserService{

	@Autowired
	private OnlineUserMapper onlineUserMapper;
	
	@Override
	public BasicMapper<OnlineUser> getBasicMapper(){
		return onlineUserMapper;
	}

	@Override
	public List<OnlineUser> querySessionIdListPage(OnlineUser onlineUser) throws Exception {
		return onlineUserMapper.querySessionIdListPage(onlineUser);
	}
}
