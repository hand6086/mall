package com.hand.base.o2odataimport.service;

import com.hand.base.basic.model.CallParam;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.o2odataimport.model.ShopkeeperTemp;

public interface ShopkeeperImpService extends BasicService<ShopkeeperTemp>{
	/**
	 * 校验店主数据
	 * @param record
	 * @throws BasicServiceException
	 */
	public void runUserCheck(CallParam record) throws BasicServiceException;
	/**
	 * 导入店主数据
	 * @param record
	 * @throws BasicServiceException
	 */
	public void runUserInsert(CallParam record) throws BasicServiceException;
}
