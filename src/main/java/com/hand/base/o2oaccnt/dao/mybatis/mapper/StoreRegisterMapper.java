package com.hand.base.o2oaccnt.dao.mybatis.mapper;

import java.util.List;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.o2oaccnt.model.StoreRegister;

public interface StoreRegisterMapper extends BasicMapper<StoreRegister> {
	public void register(StoreRegister record) throws Exception;

	// 根据电话号码查找用户
	public List<StoreRegister> getUserByPhone(StoreRegister record) throws Exception;

	// 根据用户名查找用户
	public List<StoreRegister> getUserByName(StoreRegister record) throws Exception;
	
	//更新商户状态
	public void storeStatusUpdate(StoreRegister record) throws Exception;

}
