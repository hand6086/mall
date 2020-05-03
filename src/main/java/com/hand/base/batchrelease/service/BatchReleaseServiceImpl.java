package com.hand.base.batchrelease.service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.model.CallParam;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.batchrelease.model.BatchRelease;
import com.hand.base.user.model.User;
import com.hand.core.util.UserUtil;
import com.hand.base.batchrelease.dao.mybatis.mapper.BatchReleaseMapper;
@Service
public class BatchReleaseServiceImpl extends BasicServiceImpl<BatchRelease>implements BatchReleaseService {
	@Autowired
	private BatchReleaseMapper batchReleaseMapper;
	public BasicMapper<BatchRelease> getBasicMapper() throws Exception {
		return batchReleaseMapper;
	}
	
	/**
	 * 检验优惠券字段是否有效正确
	 * @throws BasicServiceException
	 */
	public void runCouponCheck(CallParam record) throws Exception{
		try {
			User user = UserUtil.getUser(null);
			record.setParam1(user.getId());
			batchReleaseMapper.runCouponCheck(record);
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
	}

	@Override
	public void runCouponImport(CallParam record) throws Exception {
		try {
			User user = UserUtil.getUser(null);
			record.setParam1(user.getId());
			batchReleaseMapper.runCouponImport(record);
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
		
	}

	@Override
	public void allDelete() throws Exception {
		try {
			User user = UserUtil.getUser(null);
			if(user != null){
				batchReleaseMapper.allDelete(user.getId());
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
	}
}
