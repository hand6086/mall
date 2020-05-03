package com.hand.base.workbench.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.common.model.Image;
import com.hand.base.workbench.dao.mybatis.mapper.BannerMapper;
import com.hand.base.workbench.model.Banner;

@Service
public class BannerServiceImpl extends BasicServiceImpl<Banner>implements BannerService {

	@Autowired
	private BannerMapper bannerMapper;
	
	@Override
	public BasicMapper<Banner> getBasicMapper(){
		return bannerMapper;
	}
	@Transactional
	public void bannerImageUpdate(Banner record, List<Image> list) throws BasicServiceException {
		try {
			for (Image img : list) {

				record.setImage(img.getId());
				bannerMapper.bannerImageUpdate(record);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
	}
}
