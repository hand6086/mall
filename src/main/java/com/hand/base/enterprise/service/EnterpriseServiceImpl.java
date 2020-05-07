package com.hand.base.enterprise.service;

import com.hand.base.basic.dao.KeyGenerateDao;
import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.duty.dao.mybatis.mapper.DutyMapper;
import com.hand.base.enterprise.dao.mybatis.mapper.EnterpriseMapper;
import com.hand.base.enterprise.model.Enterprise;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;


@Service
public class EnterpriseServiceImpl  extends BasicServiceImpl<Enterprise>implements EnterpriseService {

	@Resource
	private EnterpriseMapper enterpriseMapper;
	
	@Resource
	private DutyMapper dutyMapper;
	
	@Autowired
	private KeyGenerateDao keyGenerateDao;
	
	@Override
	public BasicMapper<Enterprise> getBasicMapper() {
		return enterpriseMapper;
	}
	

}
