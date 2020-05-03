package com.hand.base.workbench.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.workbench.dao.mybatis.mapper.MesPushMapper;
import com.hand.base.workbench.model.MesPush;

@Service
public class MesPushServiceImpl extends BasicServiceImpl<MesPush>implements MesPushService {

	@Autowired
	private MesPushMapper mesPushMapper;
	
	@Override
	public BasicMapper<MesPush> getBasicMapper(){
		return mesPushMapper;
	}
	
	public List<MesPush> queryByAllCityPage(MesPush entity) throws Exception{
		return mesPushMapper.queryByAllCityPage(entity);
	}

}
