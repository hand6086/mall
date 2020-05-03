 package com.hand.base.user.dao.mybatis.mapper;

import java.util.List;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.model.CallParam;
import com.hand.base.user.model.AppUser;

public interface AppUserMapper extends BasicMapper<AppUser>{
	/**
	 * 记录总数
	 */
	public int queryAppUserCount(AppUser entity) throws Exception;
	
	public void insert(CallParam record) throws Exception;
	
	public void storeEmployeeInsert(CallParam record) throws Exception;
	
	public void updateAccnt(AppUser entity) throws Exception;
	
	public void updateUserName(AppUser entity) throws Exception;
	
	public void updateContactX(AppUser entity) throws Exception;
	
	public void deleteFromBaseUser(AppUser entity) throws Exception;
	
	public void deleteFromBaseContact(AppUser entity) throws Exception;
	
	public void deleteFromContactX(AppUser entity) throws Exception;
	
	public void deleteFromAccnt(AppUser entity) throws Exception;
	
	public List<AppUser> queryByPhone(AppUser entity) throws Exception;
}