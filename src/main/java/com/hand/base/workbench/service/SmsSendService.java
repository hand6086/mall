package com.hand.base.workbench.service;

import com.hand.base.workbench.model.SmsSend;

import java.util.List;

import com.hand.base.basic.service.BasicService;

public interface SmsSendService extends BasicService<SmsSend> {
	
    public List<SmsSend> querySmsAll(SmsSend entity) throws Exception;
    
    public List<SmsSend> querySmsLotAll(SmsSend entity) throws Exception;
    
    public List<SmsSend> querySmsLineAll(SmsSend entity) throws Exception;
    
    public List<SmsSend> queryDistinctSmsAll(SmsSend entity) throws Exception;
	
}
