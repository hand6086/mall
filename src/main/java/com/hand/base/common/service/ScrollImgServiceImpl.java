package com.hand.base.common.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.common.dao.mybatis.mapper.ScrollImgMapper;
import com.hand.base.common.model.ScrollImg;
import com.hand.core.util.StringUtils;

@Service
public class ScrollImgServiceImpl extends BasicServiceImpl<ScrollImg>implements ScrollImgService {

	@Resource
	private ScrollImgMapper scrollImgMapper;

	@Override
	public BasicMapper<ScrollImg> getBasicMapper() {
		return scrollImgMapper;
	}
	
	@Override
	public void beforInsert(ScrollImg entity) throws Exception {
		super.beforInsert(entity);
		if(StringUtils.isBlank(entity.getAppType())){
			throw new Exception("系统类型不能为空。");
		}
		if(StringUtils.isBlank(entity.getActiveFlag())){
			throw new Exception("【有效】字段不能为空。");
		}
	}
	
	@Override
	public void imgIdUpdate(ScrollImg entity) throws Exception {
		scrollImgMapper.imgIdUpdate(entity);
	}
}
