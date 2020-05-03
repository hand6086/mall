package com.hand.base.brandWorkbench.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.brandWorkbench.dao.mybatis.mapper.ClassifyMapper;
import com.hand.base.brandWorkbench.model.Classify;

@Service
public class ClassifyServiceImpl extends BasicServiceImpl<Classify>implements ClassifyService {

	@Autowired
	private ClassifyMapper classifyMapper;
	
	@Override
	public BasicMapper<Classify> getBasicMapper(){
		return classifyMapper;
	}
	
}
