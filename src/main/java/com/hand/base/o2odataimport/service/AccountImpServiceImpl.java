package com.hand.base.o2odataimport.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.model.CallParam;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.o2odataimport.dao.mybatis.mapper.AccountImpMapper;
import com.hand.base.o2odataimport.model.AccountTemp;
import com.hand.base.user.model.User;
import com.hand.core.util.UserUtil;
@Service
public class AccountImpServiceImpl extends BasicServiceImpl<AccountTemp> implements AccountImpService{
	@Autowired
	private AccountImpMapper acctImpMapper;
	
	public BasicMapper<AccountTemp> getBasicMapper(){
		return acctImpMapper;
	}

	@Transactional //Spring中用于声明事务
	public String batchDeleteById(List<AccountTemp> list) throws Exception {
		String defStId = null;
		if(list.size()==1){
			defStId = list.get(0).getId();
		}
		for(int i =0;list != null && i < list.size();i++){
			deleteById(list.get(i));
		}
		return defStId;
	}
	
	@Transactional
	public void runAccountCheck(CallParam record) throws BasicServiceException {
		try {
			User user = UserUtil.getUser(null);
			record.setParam1(user.getId());
			acctImpMapper.runAccountCheck(record);
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
	}
	
	@Transactional
	public void runAccountInsert(CallParam record) throws BasicServiceException {
		try {
			User user = UserUtil.getUser(null);
			record.setParam1(user.getId());
			acctImpMapper.runAccountInsert(record);
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
	}
}
