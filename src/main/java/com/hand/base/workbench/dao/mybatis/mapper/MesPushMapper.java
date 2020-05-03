package com.hand.base.workbench.dao.mybatis.mapper;

import java.util.List;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.workbench.model.MesPush;

public interface MesPushMapper extends BasicMapper<MesPush>{
	
	public List<MesPush> queryByAllCityPage(MesPush entity) throws Exception;
	
}