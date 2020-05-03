package com.hand.base.accountmanagement.service;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.accountmanagement.dao.mybatis.mapper.DepositMapper;
import com.hand.base.accountmanagement.model.PayInfo;
import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.basic.service.KeyGenerateService;
import com.hand.base.user.model.User;
import com.hand.core.util.UserUtil;

@Service
public class DepositServiceImpl extends BasicServiceImpl<PayInfo> implements DepositService{
	@Autowired
	protected KeyGenerateService keyGenerateService;
	@Resource
	private DepositMapper depositMapper;

	@Override
	public BasicMapper<PayInfo> getBasicMapper() {
		return depositMapper;
	}

	@Override
	public void insertDeposit(PayInfo entity) throws Exception {
		String id = keyGenerateService.keyGenerate();
		User user = UserUtil.getUser(null);
		entity.setId(id);
		entity.setCreatedBy(user.getCreatedBy());
		entity.setLastUpdatedBy(user.getLastUpdatedBy());
		depositMapper.insertDeposit(entity);
	}
}
