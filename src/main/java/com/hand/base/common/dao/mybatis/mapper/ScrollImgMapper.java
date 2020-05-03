package com.hand.base.common.dao.mybatis.mapper;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.common.model.ScrollImg;

public interface ScrollImgMapper extends BasicMapper<ScrollImg> {

	/**
	 * 更新图片ID
	 */
	public void imgIdUpdate(ScrollImg entity) throws Exception;
}
