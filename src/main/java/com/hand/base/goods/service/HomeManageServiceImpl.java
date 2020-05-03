package com.hand.base.goods.service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.goods.dao.mybatis.mapper.HomeManageMapper;
import com.hand.base.goods.model.HomeManage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class HomeManageServiceImpl extends BasicServiceImpl<HomeManage>implements HomeManageService {

	@Autowired
	private HomeManageMapper homeManageMapper;
	
	@Override
	public BasicMapper<HomeManage> getBasicMapper(){
		return homeManageMapper;
	}

}
