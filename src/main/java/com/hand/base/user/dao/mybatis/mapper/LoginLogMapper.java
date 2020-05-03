package com.hand.base.user.dao.mybatis.mapper;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.user.model.LoginLog;

public interface LoginLogMapper extends BasicMapper<LoginLog>{
	/**
	 * 添加登录成功记录
	 * @param loginLog
	 * @throws Exception
	 */
	public void addLoginSuccessLog(LoginLog loginLog) throws  Exception;
	/**
	 * 添加登录失败记录
	 * @param loginLog
	 * @throws Exception
	 */
	public void addLoginFailLog(LoginLog loginLog) throws Exception;
	
}