package com.hand.base.promotion.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.promotion.dao.mybatis.mapper.GroupUserMapper;
import com.hand.base.promotion.model.GroupUser;


@Service
public class GroupUserServiceImpl extends BasicServiceImpl<GroupUser>implements GroupUserService {
	@Autowired
	private GroupUserMapper groupUserMapper;
	
	@Override
	public BasicMapper<GroupUser> getBasicMapper(){
		return groupUserMapper;
	}
}
