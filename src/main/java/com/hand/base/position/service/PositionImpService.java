package com.hand.base.position.service;

import com.hand.base.basic.model.CallParam;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.position.model.Position;

public interface PositionImpService extends BasicService<Position> {
	
	/**
	 * 检验组织类型、父组织、是否有效
	 * @throws BasicServiceException
	 */
	public void runPositionCheck(CallParam record) throws BasicServiceException;
	
	/**
	 * 插入到组织
	 * @throws BasicServiceException
	 */
	public void runNewPositionForimp(CallParam record) throws BasicServiceException;
	
}
