package com.hand.base.workbench.service;

import com.hand.base.workbench.model.Campaign;

import java.util.List;

import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.common.model.Image;

public interface CampaignService extends BasicService<Campaign> {

    public void campImageUpdate(Campaign record, List<Image> list) throws BasicServiceException;
	
	public void lineImageUpdate(Campaign record, List<Image> list) throws BasicServiceException;
	
	public List<Campaign> queryByConsDrawPage(Campaign entity) throws Exception;
	
}
