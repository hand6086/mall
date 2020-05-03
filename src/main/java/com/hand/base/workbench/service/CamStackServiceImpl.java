package com.hand.base.workbench.service;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.workbench.dao.mybatis.mapper.CamStackMapper;
import com.hand.base.workbench.model.CamStack;

@Service
public class CamStackServiceImpl extends BasicServiceImpl<CamStack>implements CamStackService {

	@Autowired
	private CamStackMapper camStackMapper;
	
	@Override
	public BasicMapper<CamStack> getBasicMapper(){
		return camStackMapper;
	}

}
