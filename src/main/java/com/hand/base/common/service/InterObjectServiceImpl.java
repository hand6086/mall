package com.hand.base.common.service;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.common.dao.mybatis.mapper.InterObjectMapper;
import com.hand.base.common.model.InterObject;

@Service
@Transactional
public class InterObjectServiceImpl implements InterObjectService {

	private static final Logger logger = LogManager.getLogger(AttachmentServiceImpl.class);
	
	@Autowired
	private InterObjectMapper interObjectMapper;
	
	
	public void announceAttachInsert(InterObject record) throws BasicServiceException {
		try{
			interObjectMapper.announceAttachInsert(record);
		}catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
	}


	

}
