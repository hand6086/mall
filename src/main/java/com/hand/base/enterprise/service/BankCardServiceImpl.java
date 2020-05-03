package com.hand.base.enterprise.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.enterprise.dao.mybatis.mapper.BankCardMapper;
import com.hand.base.enterprise.model.BankCard;


@Service
public class BankCardServiceImpl  extends BasicServiceImpl<BankCard>implements BankCardService {

	@Resource
	private BankCardMapper bankCardMapper;
	
	@Override
	public BasicMapper<BankCard> getBasicMapper() {
		return bankCardMapper;
	}
}
