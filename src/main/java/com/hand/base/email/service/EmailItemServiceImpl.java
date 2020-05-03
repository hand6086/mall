package com.hand.base.email.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.email.dao.mybatis.mapper.EmailItemMapper;
import com.hand.base.email.model.EmailItem;
import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;

@Service
public class EmailItemServiceImpl extends BasicServiceImpl<EmailItem> implements EmailItemService{

	@Autowired
	private EmailItemMapper emailItemMapper;
	
	@Override
	public BasicMapper<EmailItem> getBasicMapper(){
		return emailItemMapper;
	}
	
}
