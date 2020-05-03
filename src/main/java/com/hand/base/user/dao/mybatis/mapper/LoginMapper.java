 package com.hand.base.user.dao.mybatis.mapper;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.user.model.User;

public interface LoginMapper extends BasicMapper<User>{
    
    /**
	 * 更新最后登录时间
	 * @param record 用户信息
	 */
    public void lastLoginDateUpdate(User record) throws Exception;
    
       
    /**
     * 根据用户名查询用户信息
     * @param username
     * @return
     */
    public User queryByUsername(User record) throws Exception;

    /**
     * 根据手机号查询用户
     * @param record
     * @return
     * @author anxiaobo
     * @date 2019/04/22 11:05
     * @throws Exception
     */
    public User queryByPhone(User record) throws Exception;
	
}