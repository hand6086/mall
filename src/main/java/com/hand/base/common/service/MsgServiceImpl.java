package com.hand.base.common.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hand.base.basic.dao.KeyGenerateDao;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.common.dao.mybatis.mapper.MsgMapper;
import com.hand.base.common.model.Msg;
import com.hand.base.user.model.User;

@Service
@Transactional
public class MsgServiceImpl implements MsgService{

	@Autowired
	private MsgMapper msgMapper;
	
	@Autowired
	private KeyGenerateDao keyGenerateDao;
	
	public List<Msg> queryMsg(Msg msg) throws BasicServiceException{
		List<Map> list = null;
		try {
			//list = msgMapper.queryMsg(msg);
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
		
		if(list == null)
		{
			return null;
		}
		return getRecord(list);
	}
	
	private List<Msg> getRecord(List<Map> list)
	{
		List<Msg> result = new ArrayList<Msg>();
		
		for(Map map : list)
		{
			Msg msg = new Msg();
			msg.setId((String) map.get("id"));
			msg.setTitle((String) map.get("title"));
			msg.setBeginTime((String) map.get("begin_time"));
			msg.setIsAllValid((String) map.get("is_all_valid"));
			msg.setIsPublished((String)map.get("is_published"));
			msg.setCreatedBy((String) map.get("created_by"));
			msg.setLastUpdatedBy((String) map.get("last_upd_by"));
			msg.setType((String)map.get("type"));
			msg.setMsgContent((String)map.get("msg_content"));
			/*
			Blob blob = (Blob) map.get("msg_content");
			if(blob != null)
			{
				String msgContent = new String(blob.getBytes(1, (int)blob.length()),"GBK");
				msg.setMsgContent(msgContent);
			}*/
			result.add(msg);
		}
		return result;
	}

	public void addOrUpdate(Msg record, User login) throws BasicServiceException {
		try {
			String id = keyGenerateDao.keyGenerate();
			record.setId(id);
			msgMapper.msgInsert(record);
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
		
		
	}

}
