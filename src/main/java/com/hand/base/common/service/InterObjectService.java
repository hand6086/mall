package com.hand.base.common.service;

import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.common.model.InterObject;

public interface InterObjectService {
	
	/**
	 * 插入公告附件表
	 * @throws BasicServiceException
	 */
	public void announceAttachInsert(InterObject record) throws BasicServiceException;
	
	
	
	
}
