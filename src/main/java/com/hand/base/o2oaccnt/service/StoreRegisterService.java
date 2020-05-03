package com.hand.base.o2oaccnt.service;

import java.util.List;

import com.hand.base.basic.service.BasicService;
import com.hand.base.o2oaccnt.model.StoreRegister;


public interface StoreRegisterService extends BasicService<StoreRegister> {
	
	public void register(StoreRegister record) throws Exception;

	// 根据电话号码查找用户
	public List<StoreRegister> getUserByPhone(StoreRegister record) throws Exception;

	// 根据用户名查找用户
	public List<StoreRegister> getUserByName(StoreRegister record) throws Exception;
	
	//更新商户状态
	public void storeStatusUpdate(StoreRegister record) throws Exception;

}
