 package com.hand.base.user.dao.mybatis.mapper;

import org.apache.ibatis.annotations.Param;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.user.model.User;

public interface UserMapper extends BasicMapper<User>{
	
    
    /**
	 * 修改Link用户密码
	 * @param record 用户信息
	 */
    public void changeUserPasswordUpdate(User record) throws Exception;
    /**
     * 修改App用户密码
     * @param record 用户信息
     */
    public void changeAppUserPasswordUpdate(User record) throws Exception;
    /**
   	 * 重置用户密码
   	 * @param record 用户信息
   	 */
    public void resetUserPassword(@Param(value = "password") String password,@Param(value = "id") String id) throws Exception;
    
    /**
     * 根据Id查询用户
     * @param record
     * @return id
     * @throws Exception
     */
    public User queryByUserId(User record) throws Exception;
	
	/**
	 * 
	 *<p>根据id查询用户基本信息，工号、用户名等</p>
	 * @author yrf
	 * @param record
	 * @return
	 * @throws Exception
	 */
	public User querySampleUserById(User record) throws Exception;
	
	
	/**
	 * 更新DMS个人信息
	 * @param record
	 * @throws Exception
	 */
	public void updateDmsProfile(User record) throws Exception;
	
	/**
	 * 修改企点信息
	 */
	public void qidianInfoUpdate(User record) throws Exception;
	
	/**
	 * 修改主要职位
	 */
	public void mainPostnUpdate(User record) throws Exception;
	/**
	 * 记录总数
	 */
	public int queryUserCount(User entity) throws Exception;
}