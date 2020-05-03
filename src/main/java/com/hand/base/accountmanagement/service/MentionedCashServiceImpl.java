package com.hand.base.accountmanagement.service;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.accountmanagement.dao.mybatis.mapper.MentionedCashMapper;
import com.hand.base.accountmanagement.model.BillInfo;
import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.basic.service.KeyGenerateService;

@Service
public class MentionedCashServiceImpl extends BasicServiceImpl<BillInfo> implements MentionedCashService{
	@Autowired
	protected KeyGenerateService keyGenerateService;
	@Resource
	private MentionedCashMapper mentionedCashMapper;

	@Override
	public BasicMapper<BillInfo> getBasicMapper() {
		return mentionedCashMapper;
	}
}
