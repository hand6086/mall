package com.hand.base.rongcloud.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.rongcloud.dao.mybatis.mapper.RcsMerchantMapper;
import com.hand.base.rongcloud.model.RcsMerchant;

@Service
public class RcsMerchantServiceImpl  extends BasicServiceImpl<RcsMerchant> implements RcsMerchantService {
	@Autowired
	public RcsMerchantMapper merchantMapper;
	@Override
	public BasicMapper<RcsMerchant> getBasicMapper(){
		return merchantMapper;
	}

}
