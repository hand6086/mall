package com.hand.base.o2odataimport.dao.mybatis.mapper;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.model.CallParam;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.o2odataimport.model.RestaurantTemp;

public interface RestaurantImpMapper extends BasicMapper<RestaurantTemp> {

	/**
	 * 检验字段是否有效正确
	 * @throws BasicServiceException
	 */
	public void runRestaurantCheck(CallParam record) throws Exception;
	
	/**
	 * 导入校验正确字段
	 * @throws BasicServiceException
	 */
	public void runRestaurantImp(CallParam record) throws Exception;
}
