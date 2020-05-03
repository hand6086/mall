package com.hand.base.accountmanagement.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.accountmanagement.dao.mybatis.mapper.AvailableCashMapper;
import com.hand.base.accountmanagement.model.PayInfo;
import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.basic.service.KeyGenerateService;

@Service
public class AvailableCashServiceImpl extends BasicServiceImpl<PayInfo> implements AvailableCashService {
	@Autowired
	protected KeyGenerateService keyGenerateService;
	@Resource
	private AvailableCashMapper availableCashMapper;

	@Override
	public BasicMapper<PayInfo> getBasicMapper() {
		return availableCashMapper;
	}

	@Override
	public void fundStatusUpdate(PayInfo entity) throws Exception {
		availableCashMapper.fundsStatusUpdate(entity);
	}

	@Override
	public List<PayInfo> queryByBillId(PayInfo entity) throws Exception {
		return availableCashMapper.queryByBillIdPage(entity);
	}

	@Override
	public List<PayInfo> brandQueryByBillId(PayInfo entity) throws Exception {
		return availableCashMapper.brandQueryByBillIdPage(entity);
	}
	
}
