package com.hand.base.user.service;

import java.util.List;

import com.hand.base.basic.service.BasicService;
import com.hand.base.user.model.OnlineUser;

public interface OnlineUserService extends BasicService<OnlineUser>{

	/**
	 * 分页查询sessionId列表；由于sessionId数据比较敏感，所以独立写一个查询方法
	 */
	public List<OnlineUser> querySessionIdListPage(OnlineUser onlineUser) throws Exception;
	
}
