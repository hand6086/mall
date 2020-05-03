package com.hand.base.workbench.service;

import com.hand.base.workbench.model.Button;

import java.util.List;

import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.common.model.Image;

public interface ButtonService extends BasicService<Button> {
	
	/**
	 * 添加图片
	 * @param list
	 * @throws BasicServiceException
	 */
	public void buttonImageUpdate(Button record, List<Image> list) throws BasicServiceException;
	
	public void cityImageUpdate(Button record, List<Image> list) throws BasicServiceException;
	
}
