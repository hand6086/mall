package com.hand.base.rongcloud.dao.mybatis.mapper;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.rongcloud.model.RcsUser;

public interface RcsUserMapper  extends BasicMapper<RcsUser>{
	
	/**
	 * 更新融云token
	 * @param entity
	 */
	public void updateRongToken(RcsUser entity) throws Exception;
}