package com.hand.base.workbench.dao.mybatis.mapper;

import java.util.List;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.workbench.model.SmsSend;

public interface SmsSendMapper extends BasicMapper<SmsSend>{
	
	public List<SmsSend> querySmsAll(SmsSend entity) throws Exception;
	
	public List<SmsSend> querySmsLotAll(SmsSend entity) throws Exception;
	
	public List<SmsSend> querySmsLineAll(SmsSend entity) throws Exception;
	
	public List<SmsSend> queryDistinctSmsAll(SmsSend entity) throws Exception;
	
}