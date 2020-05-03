package com.hand.base.user.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.model.CallParam;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.basic.service.KeyGenerateService;
import com.hand.base.user.dao.mybatis.mapper.UserImpMapper;
import com.hand.base.user.model.User;
import com.hand.core.util.UserUtil;

@Service
public class UserImpServiceImpl extends BasicServiceImpl<User>  implements UserImpService{
	
	//private static final Logger logger = LogManager.getLogger(UserServiceImpl.class);
	
	@Autowired
	private UserImpMapper userImpMapper;
	
	@Autowired
	protected KeyGenerateService keyGenerateService;
	
	public BasicMapper<User> getBasicMapper(){
		return userImpMapper;
	}
	/**
	 * 根据用户名查找用户
	 * @param username 用户名
	 * @return 用户信息
	 */
	public User queryByUsername(String username) throws BasicServiceException{
		//忽略大小写,自动转换成大写
		String usernameUpperCase = username.toUpperCase();
		User record = new User();
		record.setUsername(usernameUpperCase);
		try {
			return userImpMapper.queryByUsername(record);
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
	}
	
	@Transactional
	public void runUserCheck(CallParam record) throws BasicServiceException {
		try {
			User user = UserUtil.getUser(null);
			record.setParam1(user.getId());
			userImpMapper.runUserCheck(record);
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
	}
	
	@Transactional
	public void runNewUserForimp(CallParam record) throws BasicServiceException {
		try {
			User user = UserUtil.getUser(null);
			record.setParam1(user.getId());
			userImpMapper.runUserCheck(record);
			userImpMapper.runNewUserForimp(record);
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
	}
}
