package com.hand.base.workbench.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.common.model.Image;
import com.hand.base.workbench.dao.mybatis.mapper.CampaignMapper;
import com.hand.base.workbench.model.Campaign;

@Service
public class CampaignServiceImpl extends BasicServiceImpl<Campaign> implements CampaignService {

	@Autowired
	private CampaignMapper campaignMapper;
	
	@Override
	public BasicMapper<Campaign> getBasicMapper(){
		return campaignMapper;
	}

	@Transactional
	public void campImageUpdate(Campaign record, List<Image> list) throws BasicServiceException {
		try {
			for (Image img : list) {

				record.setCharePicId(img.getId());
				campaignMapper.campImageUpdate(record);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
	}
	
	@Transactional
	public void lineImageUpdate(Campaign record, List<Image> list) throws BasicServiceException {
		try {
			for (Image img : list) {

				record.setPicId(img.getId());
				campaignMapper.lineImageUpdate(record);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
	}
	
	public List<Campaign> queryByConsDrawPage(Campaign entity) throws Exception{
		return campaignMapper.queryByConsDrawPage(entity);
	}
	
}
