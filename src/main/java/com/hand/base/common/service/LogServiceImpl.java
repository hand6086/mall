package com.hand.base.common.service;

import java.sql.Blob;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hand.base.basic.dao.KeyGenerateDao;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.common.dao.mybatis.mapper.LogMapper;
import com.hand.base.common.model.Log;

@Service
@Transactional
public class LogServiceImpl implements LogService{
	
	@Autowired
	private LogMapper logMapper;
	
	@Autowired
	private KeyGenerateDao keyGenerateDao;

	public List<Log> queryLogs(String loginId) throws BasicServiceException {
		List<Map> list = null;
		try {
			//list = logMapper.queryLogs(loginId);
			if(list == null)
			{
				return null;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
		
		return getRecord(list);
	}

	public void addLog(Log record) throws BasicServiceException {
		
		byte[] logContents = record.getLogContent().getBytes();
		record.setLogContents(logContents);
		record.setId(keyGenerateDao.keyGenerate());
		try {
			logMapper.logInsert(record);
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
	}
	
	private List<Log> getRecord(List<Map> list) throws BasicServiceException
	{
		List<Log> result = new ArrayList<Log>();
		
		for(Map map : list)
		{
			Log log = new Log();
			log.setId((String) map.get("id"));
			log.setTypeCd("type_cd");
			log.setLogLvl("log_lvl");
			log.setCreatedBy((String) map.get("created_by"));
			log.setLastUpdatedBy((String) map.get("last_upd_by"));
			
			Blob blob = (Blob) map.get("log_content");
			if(blob != null)
			{
				//String logContent = new String(blob.getBytes(1, (int)blob.length()),"GBK");
				//log.setLogContent(logContent);
			}
		}
		return result;
	}

}
