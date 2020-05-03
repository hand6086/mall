package com.hand.base.workbench.dao.mybatis.mapper;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.workbench.model.Popup;

public interface PopupMapper extends BasicMapper<Popup>{
	
	/**
	 * 添加产品图片
	 * @param record
	 * @throws Exception
	 */
	public void popupImageUpdate(Popup record) throws Exception;
}