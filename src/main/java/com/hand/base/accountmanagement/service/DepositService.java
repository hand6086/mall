package com.hand.base.accountmanagement.service;

import com.hand.base.accountmanagement.model.PayInfo;
import com.hand.base.basic.service.BasicService;

public interface DepositService extends BasicService<PayInfo>{
	
	/**
	 * 插入押金信息
	 * 
	 * @param entity
	 * @throws Exception
	 */
	public void insertDeposit(PayInfo entity) throws Exception;
}
