package com.hand.base.user.service;

import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.model.CallParam;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.user.dao.mybatis.mapper.AppUserMapper;
import com.hand.base.user.model.AppUser;
import com.hand.core.util.StringUtils;

@Service
public class AppUserServiceImpl extends BasicServiceImpl<AppUser> implements AppUserService{
	
	private static final Logger logger = LogManager.getLogger(AppUserServiceImpl.class);
	
	@Autowired
	private AppUserMapper appUserMapper;
	
	@Override
	public BasicMapper<AppUser> getBasicMapper() throws Exception {
		return appUserMapper;
	}
	
	@Override
	public int queryAppUserCount(AppUser entity) throws Exception {
		return appUserMapper.queryAppUserCount(entity);
	}
	
	@Override
	@Transactional
	public void insert(AppUser entity) throws Exception {
		beforInsert(entity);
		beforUpsert(entity);
		postDefaultValue(entity);//设置默认值
		if(StringUtils.isBlank(entity.getId())){
			entity.setId(keyGenerateService.keyGenerate());
		}
		if(!checkData(entity)){//进行数据校验
			throw new BasicServiceException("校验不通过，请检查数据！");
		}
		
		String password = entity.getPhoneNumber();
		if(password == null || password.length() <6){
			throw new BasicServiceException("联系号码错误！");
		}
		password = password.substring(password.length()-6, password.length());
		CallParam record = new CallParam();
		record.setParam2(entity.getName());
		record.setParam3(entity.getPhoneNumber());
		record.setParam4(password);
		if("Customer".equals(entity.getUserType())){
			record.setParam1(entity.getId());
			appUserMapper.insert(record);
		}else if("Store Employee".equals(entity.getUserType())){
			record.setParam1(entity.getAttr2());
			appUserMapper.storeEmployeeInsert(record);
		}else if("Store Owner".equals(entity.getUserType())){
			record.setParam1(entity.getAttr2());
			appUserMapper.storeEmployeeInsert(record);
			
			AppUser appUser = new AppUser();
			appUser.setUserType("Store Employee");
			appUser.setPhoneNumber(entity.getPhoneNumber());
			
			List<AppUser> appUserList= appUserMapper.queryByPhone(appUser);
			if(appUserList.size() == 1){
				appUser.setUserType(entity.getUserType());
				appUser.setId(appUserList.get(0).getId());
				appUserMapper.updateContactX(appUser);
			}
		}
		
	}
	
	@Override
	public void beforUpsert(AppUser entity) throws Exception{
		if("Store Employee".equals(entity.getUserType()) || "Store Owner".equals(entity.getUserType())){
			AppUser appUser = new AppUser();
			appUser.setId(entity.getId());
			appUser.setPhoneNumber(entity.getPhoneNumber());
			appUser.setUserType("Store Employee");
			if(appUserMapper.queryByPhone(appUser).size()>0){
				throw new BasicServiceException("该号码已经注册！");
			}
			appUser.setUserType("Store Owner");
			if(appUserMapper.queryByPhone(appUser).size()>0){
				throw new BasicServiceException("该号码已经注册！");
			}
		}else{
			if(appUserMapper.queryByPhone(entity).size()>0){
				throw new BasicServiceException("该用户已经注册！");
			}
		}
	}
	
	@Override
	@Transactional
	public void update(AppUser entity) throws Exception {
		beforUpdate(entity);
		beforUpsert(entity);
		if(!checkData(entity)){//进行数据校验
			throw new BasicServiceException("校验不通过，请检查数据！");
		}
		checkId(entity);
		appUserMapper.updateAccnt(entity);
		appUserMapper.updateUserName(entity);
		appUserMapper.updateContactX(entity);
		afterUpdate(entity);
	}
	
	@Override
	@Transactional
	public void deleteById(AppUser entity) throws Exception {
		beforDelete(entity);
		checkId(entity);
		appUserMapper.deleteFromBaseUser(entity);
		appUserMapper.deleteFromBaseContact(entity);
		appUserMapper.deleteFromContactX(entity);
		appUserMapper.deleteFromAccnt(entity);
	}
}
