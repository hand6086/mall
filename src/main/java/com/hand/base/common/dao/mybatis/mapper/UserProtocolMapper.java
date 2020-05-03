package com.hand.base.common.dao.mybatis.mapper;

import com.hand.base.common.model.UserProtocol;

public interface UserProtocolMapper {

	public UserProtocol queryProtocolStatusByLoginName(String loginName) throws Exception;
	
	public void InsertUserProtocol(UserProtocol record)throws Exception;
	public void userProtocolInsert(UserProtocol record)throws Exception;
	
	
	public UserProtocol queryUserNameExist(String loginName)throws Exception;
	
}
