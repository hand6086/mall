package com.hand.base.workbench.service;

import com.hand.base.workbench.model.Popup;

import java.util.List;

import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.common.model.Image;


public interface PopupService extends BasicService<Popup> {
	
	/**
	 * 添加图片
	 * @param list
	 * @throws BasicServiceException
	 */
	public void popupImageUpdate(Popup record, List<Image> list) throws BasicServiceException;
	
}
