package com.hand.base.user.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.user.dao.mybatis.mapper.LoginLogMapper;
import com.hand.base.user.model.LoginLog;

@Service
public class LoginLogServiceImpl extends BasicServiceImpl<LoginLog> implements LoginLogService{

	@Resource
	private LoginLogMapper loginLogMapper;
	
	@Override
	public BasicMapper<LoginLog> getBasicMapper(){
		return loginLogMapper;
	}
	
	public void deleteByUserId(String userId) throws BasicServiceException{
		// TODO Auto-generated method stub
		
	}
	
	public void addLoginSuccessLog(LoginLog record) throws BasicServiceException{
		try {
			record.setId(keyGenerateService.keyGenerate());
			loginLogMapper.addLoginSuccessLog(record);
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
	}
	
	public void addLoginFailLog(LoginLog record) throws BasicServiceException{
		try {
			loginLogMapper.addLoginFailLog(record);
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
	}
	
	
	
}