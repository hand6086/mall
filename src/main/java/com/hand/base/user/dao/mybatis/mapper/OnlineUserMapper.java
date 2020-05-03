package com.hand.base.user.dao.mybatis.mapper;

import java.util.List;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.user.model.OnlineUser;

public interface OnlineUserMapper extends BasicMapper<OnlineUser>{
	
	/**
	 * 分页查询sessionId列表；由于sessionId数据比较敏感，所以独立写一个查询方法
	 */
	public List<OnlineUser> querySessionIdListPage(OnlineUser onlineUser) throws Exception; 
}
