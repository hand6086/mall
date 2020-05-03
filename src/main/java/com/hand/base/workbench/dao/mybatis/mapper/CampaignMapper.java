package com.hand.base.workbench.dao.mybatis.mapper;

import java.util.List;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.workbench.model.Campaign;

public interface CampaignMapper extends BasicMapper<Campaign>{
	
    public void campImageUpdate(Campaign record) throws Exception;
	
	public void lineImageUpdate(Campaign record) throws Exception;
	
	public List<Campaign> queryByConsDrawPage(Campaign entity) throws Exception;
}