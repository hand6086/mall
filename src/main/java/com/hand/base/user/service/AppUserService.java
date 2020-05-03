package com.hand.base.user.service;

import com.hand.base.basic.service.BasicService;
import com.hand.base.user.model.AppUser;


public interface AppUserService extends BasicService<AppUser>{
	
	public int queryAppUserCount(AppUser entity) throws Exception;
}
