package com.hand.base.accountmanagement.dao.mybatis.mapper;

import com.hand.base.accountmanagement.model.PayInfo;
import com.hand.base.basic.dao.mapper.BasicMapper;

public interface DepositMapper extends BasicMapper<PayInfo> {
	/**
	 * 插入押金信息
	 * 
	 * @param entity
	 * @throws Exception
	 */
	public void insertDeposit(PayInfo entity) throws Exception;
}
