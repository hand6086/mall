package com.hand.base.common.service;

import com.hand.base.basic.service.BasicService;
import com.hand.base.common.model.ScrollImg;

public interface ScrollImgService extends BasicService<ScrollImg> {

	/**
	 * 更新图片ID
	 */
	public void imgIdUpdate(ScrollImg entity) throws Exception;
}
