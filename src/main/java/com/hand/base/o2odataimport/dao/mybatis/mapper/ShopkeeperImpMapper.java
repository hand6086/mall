package com.hand.base.o2odataimport.dao.mybatis.mapper;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.model.CallParam;
import com.hand.base.o2odataimport.model.ShopkeeperTemp;

public interface ShopkeeperImpMapper extends BasicMapper<ShopkeeperTemp> {
	/**
	 * 校验店主数据
	 * @param record
	 * @throws Exception
	 */
	public void runUserCheck(CallParam record) throws Exception;
	/**
	 * 导入店主数据
	 * @param record
	 * @throws Exception
	 */
	public void runUserInsert(CallParam record) throws Exception;
}
