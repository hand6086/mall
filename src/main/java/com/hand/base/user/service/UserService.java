package com.hand.base.user.service;

import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.user.model.User;


public interface UserService extends BasicService<User>{
	
	
	public String modifyPassword(User user, String oldPassword,
			String newPassword, String confirmPassword) throws BasicServiceException;
	
	public String resetPassword(User user,String newPassword, String confirmPassword) throws BasicServiceException;
	
	public String modifyEmpLoyeePassword(String id,String empType, String newPassword, String confirmPassword) throws BasicServiceException;
	
	/**
	 * 根据用户名查找用户
	 * @param username 用户名
	 * @return 用户信息
	 */
	public User getUserByUsername(String username) throws BasicServiceException;

	/**
	 * 根据手机号查找用户
	 * @author anxiaobo
	 * @date 2019/04/22 11:05
	 * @param phone 手机号
	 * @return 用户信息
	 */
	public User getUserByPhone(String phone) throws BasicServiceException;

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
	 * 
	 *<p>外部用户新建默认值</p>
	 * @return
	 */
	public User outerPreDefaultValue() throws Exception;
	
	/**
	 * 修改企点信息
	 */
	public void qidianInfoUpdate(User record) throws Exception;
	
	/**
	 * 修改主要职位
	 * @param userId 用户ID
	 * @param postnId 职位ID
	 */
	public void mainPostnUpdate(String userId, String postnId) throws Exception;
	
	public int queryUserCount(User entity) throws Exception;
}
