package com.hand.base.workbench.dao.mybatis.mapper;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.workbench.model.Button;

public interface ButtonMapper extends BasicMapper<Button>{
	
	/**
	 * 添加产品图片
	 * @param record
	 * @throws Exception
	 */
	public void buttonImageUpdate(Button record) throws Exception;
	
	public void cityImageUpdate(Button record) throws Exception;
		
}