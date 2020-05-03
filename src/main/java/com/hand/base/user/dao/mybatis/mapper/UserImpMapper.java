 package com.hand.base.user.dao.mybatis.mapper;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.model.CallParam;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.user.model.User;

public interface UserImpMapper extends BasicMapper<User>{
       
    /**
     * 根据用户名查询用户信息
     * @param username
     * @return
     */
    public User queryByUsername(User record) throws Exception; 

    /**
	 * 检验用户信息是否有效
	 * @throws BasicServiceException
	 */
	public void runUserCheck(CallParam record) throws Exception;
	
	/**
	 * 插入到用户
	 * @throws BasicServiceException
	 */
	public void runNewUserForimp(CallParam record) throws Exception;
}