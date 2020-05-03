package com.hand.base.rongcloud.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.rongcloud.dao.mybatis.mapper.RcsUserMapper;
import com.hand.base.rongcloud.model.RcsUser;


@Service
public class RcsUserServiceImpl extends BasicServiceImpl<RcsUser> implements RcsUserService{
	@Autowired
	public RcsUserMapper userMapper;
	@Override
	public BasicMapper<RcsUser> getBasicMapper(){
		return userMapper;
	}
	/**
	 * 更新融云token
	 * @param entity
	 */
	@Override
	@Transactional
	public void update(RcsUser entity) throws Exception {
		if(!checkData(entity)){//进行数据校验
			throw new BasicServiceException("校验不通过，请检查数据！");
		}
		checkId(entity);
		userMapper.updateRongToken(entity);
	}
	
}
