package com.hand.base.accountmanagement.service;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.accountmanagement.dao.mybatis.mapper.UnIntoAccountMapper;
import com.hand.base.accountmanagement.model.PayInfo;
import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.basic.service.KeyGenerateService;

@Service
public class UnIntoAccountServiceImpl extends BasicServiceImpl<PayInfo> implements UnIntoAccountService{
	@Autowired
	protected KeyGenerateService keyGenerateService;
	@Resource
	private UnIntoAccountMapper unIntoAccountMapper;

	@Override
	public BasicMapper<PayInfo> getBasicMapper() {
		return unIntoAccountMapper;
	}
}
