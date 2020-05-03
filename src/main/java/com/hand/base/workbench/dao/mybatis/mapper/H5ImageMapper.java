package com.hand.base.workbench.dao.mybatis.mapper;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.workbench.model.H5Image;

public interface H5ImageMapper extends BasicMapper<H5Image>{
	
	public void h5ImageUpdate(H5Image record) throws Exception;
}