package com.hand.base.workbench.dao.mybatis.mapper;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.workbench.model.Banner;

public interface BannerMapper extends BasicMapper<Banner>{
	
	/**
	 * 添加产品图片
	 * @param record
	 * @throws Exception
	 */
	public void bannerImageUpdate(Banner record) throws Exception;
}