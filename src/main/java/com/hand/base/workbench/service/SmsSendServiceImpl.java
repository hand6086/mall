package com.hand.base.workbench.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.workbench.dao.mybatis.mapper.SmsSendMapper;
import com.hand.base.workbench.model.SmsSend;

@Service
public class SmsSendServiceImpl extends BasicServiceImpl<SmsSend> implements SmsSendService {

	@Autowired
	private SmsSendMapper smsSendMapper;
	
	
	@Override
	public BasicMapper<SmsSend> getBasicMapper(){
		return smsSendMapper;
	}
	
	public List<SmsSend> querySmsAll(SmsSend entity) throws Exception{
		return smsSendMapper.querySmsAll(entity);
	}
	
	public List<SmsSend> querySmsLineAll(SmsSend entity) throws Exception{
		return smsSendMapper.querySmsLineAll(entity);
	}
	
	
	public List<SmsSend> querySmsLotAll(SmsSend entity) throws Exception{
		return smsSendMapper.querySmsLotAll(entity);
	}
	
	
	public List<SmsSend> queryDistinctSmsAll(SmsSend entity) throws Exception{
		return smsSendMapper.queryDistinctSmsAll(entity);
	}
	
}
