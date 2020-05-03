package com.hand.base.common.service;

import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.common.model.UserProtocol;

public interface UserProtocolService {

	/**
	 * 通过登录名查询用户是否接受协议，将查询结果封装在Bean里面
	 * @param loginName
	 * @return
	 * @throws BasicServiceException
	 */
	public UserProtocol queryProtocolStatusByLoginName(String loginName) throws BasicServiceException;
	/**
	 * 向用户协议表插入数据，不拼接用户信息
	 * @param record
	 * @throws BasicServiceException
	 */
	public void InsertUserProtocol(UserProtocol record) throws BasicServiceException;
	
	/**
	 * 查询用户名是否存在，存在返回UserProtocl对象并并把用户名存进去;
	 * @param loginName
	 * @return
	 * @throws BasicServiceException
	 */
	public UserProtocol queryUserNameExist(String loginName) throws BasicServiceException;
	
	
}
