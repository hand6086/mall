package com.hand.base.message.service;

import com.hand.base.message.model.PushNotice;

import java.util.List;

import com.hand.base.basic.service.BasicService;

public interface PushNoticeService extends BasicService<PushNotice>{

	public void updateRead(PushNotice pushNotice);
	
	public void updateReadAll(PushNotice pushNotice);
	
	public void updateWebPushStatus(PushNotice pushNotice);
	
	public List<PushNotice> queryFlowByAdminPage(PushNotice entity) throws Exception;
	
	public List<PushNotice> queryFlowPage(PushNotice entity) throws Exception;
	
	public List<PushNotice> queryPushNoticePage(PushNotice entity) throws Exception;
}
