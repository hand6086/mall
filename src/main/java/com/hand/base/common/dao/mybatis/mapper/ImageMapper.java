package com.hand.base.common.dao.mybatis.mapper;

import com.hand.base.common.model.Image;

public interface ImageMapper {
    
	public void imageInsert(Image image) throws Exception;
	
	public void imageUpdate(Image image) throws Exception;
	
	public void imageDelete(Image image) throws Exception;

	
}