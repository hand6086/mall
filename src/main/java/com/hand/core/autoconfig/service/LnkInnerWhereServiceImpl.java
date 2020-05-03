package com.hand.core.autoconfig.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.core.autoconfig.dao.mybatis.mapper.LnkInnerWhereMapper;
import com.hand.core.autoconfig.model.LnkInnerWhere;

@Service
public class LnkInnerWhereServiceImpl extends BasicServiceImpl<LnkInnerWhere>implements LnkInnerWhereService {
	@Resource
	private LnkInnerWhereMapper lnkInnerWhereMapper;
	
	@Override
	public BasicMapper<LnkInnerWhere> getBasicMapper() {
		return lnkInnerWhereMapper;
	}
}
