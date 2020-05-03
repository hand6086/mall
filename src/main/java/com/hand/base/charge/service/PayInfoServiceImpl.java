package com.hand.base.charge.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.charge.dao.mybatis.mapper.PayInfoMapper;
import com.hand.base.charge.model.PayInfo;

@Service
public class PayInfoServiceImpl extends BasicServiceImpl<PayInfo> implements PayInfoService {
	@Autowired
	private PayInfoMapper payInfoMapper;

	@Override
	public BasicMapper<PayInfo> getBasicMapper() {
		return payInfoMapper;
	}

	@Override
	public List<PayInfo> queryOrderNumPage(PayInfo payInfo) throws Exception {
		return payInfoMapper.queryOrderNumPage(payInfo);
	}
}
