package com.hand.base.batchrelease.dao.mybatis.mapper;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.model.CallParam;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.batchrelease.model.BatchRelease;
public interface BatchReleaseMapper extends BasicMapper<BatchRelease> {

	/**
	 * 检验优惠券字段是否有效正确
	 * 
	 * @throws BasicServiceException
	 */
	public void runCouponCheck(CallParam record) throws Exception;
	
	/**
	 * 导入检验成功的优惠券字段
	 * 
	 * @throws BasicServiceException
	 */
	public void runCouponImport(CallParam record) throws Exception;
	
	
	/**
	 * 删除全部数据
	 * 
	 * @throws BasicServiceException
	 */
	public void allDelete(String createdBy) throws Exception;


}
