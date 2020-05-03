package com.hand.base.params.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.params.dao.mybatis.mapper.PlatformOrderPushRuleMapper;
import com.hand.base.params.model.PlatformOrderPushRule;

@Service
public class PlatformOrderPushRuleServiceImpl extends BasicServiceImpl<PlatformOrderPushRule> implements PlatformOrderPushRuleService {
	@Autowired
	private PlatformOrderPushRuleMapper platformOrderPushRuleMapper;

	@Override
	public BasicMapper<PlatformOrderPushRule> getBasicMapper() {
		return platformOrderPushRuleMapper;
	}
}
