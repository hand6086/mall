package com.hand.base.order.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.order.dao.mybatis.mapper.TransactionRecordMapper;
import com.hand.base.order.model.TransactionRecord;

@Service
public class TransactionRecordServiceImpl extends BasicServiceImpl<TransactionRecord> implements TransactionRecordService {
	@Autowired
	private TransactionRecordMapper transactionRecordMapper;

	@Override
	public BasicMapper<TransactionRecord> getBasicMapper() {
		return transactionRecordMapper;
	}
}
