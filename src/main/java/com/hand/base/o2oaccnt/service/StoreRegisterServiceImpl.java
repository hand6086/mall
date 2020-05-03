package com.hand.base.o2oaccnt.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import com.hand.base.user.dao.mybatis.mapper.TokenMapper;
import com.hand.base.user.model.Token;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.o2oaccnt.dao.mybatis.mapper.StoreRegisterMapper;
import com.hand.base.o2oaccnt.model.StoreRegister;
import com.hand.base.user.model.User;
import com.hand.core.util.UserUtil;
import org.springframework.transaction.annotation.Transactional;

@Service
public class StoreRegisterServiceImpl extends BasicServiceImpl<StoreRegister> implements StoreRegisterService {
	@Autowired
	private StoreRegisterMapper sRegisterMapper;

	@Autowired
	private TokenMapper tokenMapper;

	public BasicMapper<StoreRegister> getBasicMapper(){
		return sRegisterMapper;
	}
	
	public void register(StoreRegister record) throws Exception {
		sRegisterMapper.register(record);
	}

	public List<StoreRegister> getUserByPhone(StoreRegister record) throws Exception {
		return sRegisterMapper.getUserByPhone(record);
	}

	public List<StoreRegister> getUserByName(StoreRegister record) throws Exception {
		return sRegisterMapper.getUserByName(record);
	}

	@Transactional
	public void storeStatusUpdate(StoreRegister record) throws Exception {
		User user = UserUtil.getUser(null);
		record.setId(user.getId());
		if( !"cancel".equals(record.getStoreStatus()) ){
			switch(user.getStoreStatus()){
				case "REGISTERED": record.setStoreStatus("CHECK_PENDING");break;
				//case "CHECK_PENDING" : record.setStoreStatus("AUDIT_PASSED");break;
				//case "AUDIT_PASSED" : record.setStoreStatus("ALREADY_PAID");break;
				case "AUDIT_REJECT" : record.setStoreStatus("CHECK_PENDING");break;
				case "ALREADY_PAID" :record.setStoreStatus("SIGNED");break;
			}
		} else{
			record.setStoreStatus("REGISTERED");
		}
		sRegisterMapper.storeStatusUpdate(record);
		if("SIGNED".equals(record.getStoreStatus())){
			Token token =new Token();
			token.setId(keyGenerateService.keyGenerate());
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			token.setUsername("lnk_crm01");
			token.setPassword("96e79218965eb72c92a549dd5a330112");
			token.setStartDate(df.format(new Date()));
			token.setEndDate(df.format(new Date()));
			token.setCorpid(record.getCorpid());
			tokenMapper.insert(token);
		}
	}
}
