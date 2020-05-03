package com.hand.base.params.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.params.dao.mybatis.mapper.ClientUpdateMapper;
import com.hand.base.params.model.ClientUpdate;

@Service
public class ClientUpdateServiceImpl extends BasicServiceImpl<ClientUpdate> implements ClientUpdateService {
	@Autowired
	private ClientUpdateMapper clientUpdateMapper;

	@Override
	public BasicMapper<ClientUpdate> getBasicMapper() {
		return clientUpdateMapper;
	}

}
