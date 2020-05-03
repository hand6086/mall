package com.hand.base.workbench.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.workbench.dao.mybatis.mapper.CampaignLineMapper;
import com.hand.base.workbench.model.Campaign;

@Service
public class CampaignLineServiceImpl extends BasicServiceImpl<Campaign> implements CampaignLineService {

	@Autowired
	private CampaignLineMapper campaignLineMapper;
	
	@Override
	public BasicMapper<Campaign> getBasicMapper(){
		return campaignLineMapper;
	}

}
