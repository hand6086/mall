package com.hand.base.common.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.common.dao.mybatis.mapper.UserProtocolMapper;
import com.hand.base.common.model.UserProtocol;

@Service
@Transactional
public class UserProtocolServiceImpl implements UserProtocolService {

	@Autowired
	private UserProtocolMapper userProtocolMapper;
	
	public UserProtocol queryProtocolStatusByLoginName(String loginName)
			throws BasicServiceException {
		UserProtocol result=null;
		try{
			result=userProtocolMapper.queryProtocolStatusByLoginName(loginName);
		}catch(Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
		return result;
	}

	public void InsertUserProtocol(UserProtocol record)
			throws BasicServiceException {
		try{
			userProtocolMapper.InsertUserProtocol(record);
		}catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}

	}
	
	public UserProtocol queryUserNameExist(String loginName) throws BasicServiceException{
		UserProtocol result = null;
		try{
			result = userProtocolMapper.queryUserNameExist(loginName);
		}catch(Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
		return result;
	}
	
	

}
