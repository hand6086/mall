package com.hand.base.common.dao.mybatis.mapper;

import com.hand.base.common.model.Msg;

public interface MsgMapper {
    
	//public List<Map> queryMsg(Msg msg);
	
	public void msgInsert(Msg record) throws Exception;
	
	public void msgUpdate(Msg record) throws Exception;
	
	public void msgDelete(Msg record) throws Exception;
}