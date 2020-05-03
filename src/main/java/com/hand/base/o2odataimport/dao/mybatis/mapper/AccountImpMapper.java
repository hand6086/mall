package com.hand.base.o2odataimport.dao.mybatis.mapper;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.model.CallParam;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.o2odataimport.model.AccountTemp;

public interface AccountImpMapper extends BasicMapper<AccountTemp>{
	/**
	 * 检验客户字段是否有效正确
	 * @throws BasicServiceException
	 */
	public void runAccountCheck(CallParam record) throws Exception;
	/**
	 * 导入客户数据
	 * @param record
	 * @throws Exception
	 */
	public void runAccountInsert(CallParam record) throws Exception;
}
