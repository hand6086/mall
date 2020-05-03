package com.hand.base.workbench.dao.mybatis.mapper;

import java.util.List;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.workbench.model.CamPic;

public interface CamPicMapper extends BasicMapper<CamPic>{
	
	public List<CamPic> queryBySecKillPage(CamPic entity) throws Exception;
	
	/**
	 * 校验是否有多个秒杀活动
	 * @return
	 * @throws Exception
	 */
	public int queryActivityCount(CamPic entity) throws Exception;
	
}