package com.hand.base.workbench.service;

import com.hand.base.workbench.model.CamPic;

import java.util.List;


import com.hand.base.basic.service.BasicService;


public interface CamPicService extends BasicService<CamPic> {
	
	public List<CamPic> queryBySecKillPage(CamPic entity) throws Exception;
	
	/**
	 * 校验 单张图片承接页只能有一个有效的秒杀活动
	 * @return
	 * @throws Exception
	 */
	public int queryActivityCount(CamPic entity) throws Exception;
}
