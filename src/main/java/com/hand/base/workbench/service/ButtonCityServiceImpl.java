package com.hand.base.workbench.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.workbench.dao.mybatis.mapper.ButtonCityMapper;
import com.hand.base.workbench.model.Button;

@Service
public class ButtonCityServiceImpl extends BasicServiceImpl<Button> implements ButtonCityService {

	@Autowired
	private ButtonCityMapper buttonCityMapper;
	
	
	@Override
	public BasicMapper<Button> getBasicMapper(){
		return buttonCityMapper;
	}
	
}
