package com.hand.base.o2oaccnt.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.o2oaccnt.dao.mybatis.mapper.DealerAccountMapper;
import com.hand.base.o2oaccnt.model.DealerAccount;

@Service
public class DealerAccountServiceImpl extends BasicServiceImpl<DealerAccount> implements DealerAccountService {
	@Autowired
	private DealerAccountMapper dealerAccountMapper;

	@Override
	public BasicMapper<DealerAccount> getBasicMapper() {
		return dealerAccountMapper;
	}
}
