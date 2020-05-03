package com.hand.base.user.service;

import com.hand.base.basic.model.CallParam;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.user.model.User;


public interface UserImpService extends BasicService<User>{
	
	/**
     * 根据用户名查询用户信息
     * @param username
     * @return
     */
    public User queryByUsername(String username) throws Exception; 
	
	/**
	 * 检验用户信息是否有效
	 * @throws BasicServiceException
	 */
	public void runUserCheck(CallParam record) throws BasicServiceException;
	
	/**
	 * 插入到用户
	 * @throws BasicServiceException
	 */
	public void runNewUserForimp(CallParam record) throws BasicServiceException;
	
}
