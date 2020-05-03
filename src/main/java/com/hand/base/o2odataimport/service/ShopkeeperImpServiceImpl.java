package com.hand.base.o2odataimport.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.model.CallParam;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.o2odataimport.dao.mybatis.mapper.ShopkeeperImpMapper;
import com.hand.base.o2odataimport.model.ShopkeeperTemp;
import com.hand.base.user.model.User;
import com.hand.core.util.UserUtil;
@Service
public class ShopkeeperImpServiceImpl extends BasicServiceImpl<ShopkeeperTemp> implements ShopkeeperImpService{
	@Autowired
	private ShopkeeperImpMapper shoperImpMapper;
	
	public BasicMapper<ShopkeeperTemp> getBasicMapper(){
		return shoperImpMapper;
	}
	
	@Transactional
	public void runUserCheck(CallParam record) throws BasicServiceException {
		try {
			User user = UserUtil.getUser(null);
			record.setParam1(user.getId());
			shoperImpMapper.runUserCheck(record);
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
	}
	
	@Transactional
	public void runUserInsert(CallParam record) throws BasicServiceException {
		try {
			User user = UserUtil.getUser(null);
			record.setParam1(user.getId());
			shoperImpMapper.runUserInsert(record);
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
	}
}
