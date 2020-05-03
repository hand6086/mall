package com.hand.base.message.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hand.base.message.dao.mybatis.mapper.UserMessageMapper;
import com.hand.base.message.model.UserMessage;
import com.hand.base.basic.dao.KeyGenerateDao;
import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
/**
 * 
 * <p>用户-消息中间关系Service</p>
 * <p>Description</p>
 * <p>Company</p>
 * @author yrf
 * @date 2016年7月5日  上午9:39:55
 */
@Service
public class UserMessageServiceImpl extends BasicServiceImpl<UserMessage> implements UserMessageService{

	@Resource
	private UserMessageMapper userMessageMapper;
	@Resource
	private KeyGenerateDao keyGenerateDao;
	
	@Override
	public BasicMapper<UserMessage> getBasicMapper() {
		return userMessageMapper;
	}

	@Override
	public List<UserMessage> queryMyMessagePage(UserMessage userMsg){
		return userMessageMapper.queryMyMessagePage(userMsg);
	}
	
	@Override
	public void readFlagUpdate(UserMessage userMsg) {
		// TODO Auto-generated method stub
		userMessageMapper.readFlagUpdate(userMsg);
	}

}
