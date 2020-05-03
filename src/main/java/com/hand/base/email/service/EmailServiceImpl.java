package com.hand.base.email.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.email.dao.mybatis.mapper.EmailMapper;
import com.hand.base.email.model.EmailInfo;
import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;

@Service
public class EmailServiceImpl extends BasicServiceImpl<EmailInfo> implements EmailService{

	@Autowired
	private EmailMapper emailMapper;
	
	@Override
	public BasicMapper<EmailInfo> getBasicMapper(){
		return emailMapper;
	}
	
}
