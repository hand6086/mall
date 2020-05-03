package com.hand.base.message.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.message.dao.mybatis.mapper.PushNoticeMapper;
import com.hand.base.message.model.PushNotice;
import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.basic.service.BasicServiceImpl;

@Service
public class PushNoticeServiceImpl extends BasicServiceImpl<PushNotice> implements PushNoticeService{

	@Autowired
	private PushNoticeMapper pushNoticeMapper;
	
	public BasicMapper<PushNotice> getBasicMapper() throws Exception {
		if(pushNoticeMapper != null){
			return pushNoticeMapper;
		}
		throw new BasicServiceException("获取Basic Mapper 失败，请确认程序是否正确！");
	}
	
	@Override
	public void updateRead(PushNotice pushNotice){
		pushNoticeMapper.updateRead(pushNotice);
	}

	@Override
	public void updateReadAll(PushNotice pushNotice) {
		pushNoticeMapper.updateReadAll(pushNotice);
		
	}

	@Override
	public void updateWebPushStatus(PushNotice pushNotice) {
		// TODO Auto-generated method stub
		pushNoticeMapper.updateWebPushStatus(pushNotice);
	}
	
	public List<PushNotice> queryFlowByAdminPage(PushNotice entity) throws Exception{
		return pushNoticeMapper.queryFlowByAdminPage(entity);
	}
	
	public List<PushNotice> queryFlowPage(PushNotice entity) throws Exception{
		return pushNoticeMapper.queryFlowPage(entity);
	}
	
	public List<PushNotice> queryPushNoticePage(PushNotice entity) throws Exception{
		return pushNoticeMapper.queryPushNoticePage(entity);
	}
}
