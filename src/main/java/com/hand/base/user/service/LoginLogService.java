package com.hand.base.user.service;

import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.user.model.LoginLog;

public interface LoginLogService extends BasicService<LoginLog>{
	/**
	 * 删除用户的登录失败记录
	 * @param userId 用户Id
	 */
	public void deleteByUserId(String userId) throws BasicServiceException;
	
	/**
	 * 添加登录成功记录
	 * @param loginLog
	 * @throws Exception
	 */
	public void addLoginSuccessLog(LoginLog loginLog) throws  BasicServiceException;
	
	/**
	 * 添加登录失败记录
	 * @param loginLog
	 * @throws Exception
	 */
	public void addLoginFailLog(LoginLog loginLog) throws BasicServiceException;
	
}