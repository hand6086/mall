package com.hand.base.workbench.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.workbench.dao.mybatis.mapper.CamPicMapper;
import com.hand.base.workbench.model.CamPic;

@Service
public class CamPicServiceImpl extends BasicServiceImpl<CamPic>implements CamPicService {

	@Autowired
	private CamPicMapper camPicMapper;
	
	@Override
	public BasicMapper<CamPic> getBasicMapper(){
		return camPicMapper;
	}
	
	public List<CamPic> queryBySecKillPage(CamPic entity) throws Exception{
		return camPicMapper.queryBySecKillPage(entity);
	}

	@Override
	public int queryActivityCount(CamPic entity) throws Exception {
		return camPicMapper.queryActivityCount(entity);
	}
	
}
