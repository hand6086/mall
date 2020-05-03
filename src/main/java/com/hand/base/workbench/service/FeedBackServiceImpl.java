package com.hand.base.workbench.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.user.model.User;
import com.hand.base.workbench.dao.mybatis.mapper.FeedBackMapper;
import com.hand.base.workbench.model.FeedBack;
import com.hand.core.util.UserUtil;

@Service
public class FeedBackServiceImpl extends BasicServiceImpl<FeedBack>implements FeedBackService {

	@Autowired
	private FeedBackMapper feedBackMapper;
	
	@Override
	public BasicMapper<FeedBack> getBasicMapper(){
		return feedBackMapper;
	}

	@Override
	public void beforInsert(FeedBack entity) throws Exception{
		if(entity.getType().equals("申诉回复")){
		User user = UserUtil.getUser(null);
		entity.setUserId(user.getId());
		entity.setPhoneNumber(user.getContactPhone());
		}
	}
}
