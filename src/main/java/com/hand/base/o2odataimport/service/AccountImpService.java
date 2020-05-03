package com.hand.base.o2odataimport.service;

import com.hand.base.basic.model.CallParam;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.o2odataimport.model.AccountTemp;

public interface AccountImpService extends BasicService<AccountTemp>{
	/**
	 * 批量删除列表数据
	 * @param entity
	 * @return id
	 */
	//public String batchDeleteById(List<AccountTemp> list) throws Exception;
	

	/**
	 * 检验客户字段是否有效正确
	 * @throws BasicServiceException
	 */
	public void runAccountCheck(CallParam record) throws Exception;
	/**
	 * 导入客户字段
	 * @throws BasicServiceException
	 */
	public void runAccountInsert(CallParam record) throws Exception;
}
