package com.hand.base.workbench.service;

import com.hand.base.workbench.model.MesPush;

import java.util.List;

import com.hand.base.basic.service.BasicService;



public interface MesPushService extends BasicService<MesPush> {
	
	public List<MesPush> queryByAllCityPage(MesPush entity) throws Exception;

}
