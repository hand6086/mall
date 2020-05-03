package com.hand.base.common.service;

import java.util.List;

import com.hand.base.common.model.Msg;
import com.hand.base.user.model.User;

public interface MsgService {
	
	public List<Msg> queryMsg(Msg msg) throws Exception;
	
	public void addOrUpdate(Msg record, User login) throws Exception;
	

}
