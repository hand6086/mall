package com.hand.base.audittrail.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.audittrail.dao.mybatis.mapper.AuditTrailMapper;
import com.hand.base.audittrail.model.AuditTrail;
import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;

@Service
public class AuditTrailServiceImpl extends BasicServiceImpl<AuditTrail> implements AuditTrailService  {
	@Autowired
	private AuditTrailMapper auditTrailMapper;
	
	@Override
	public BasicMapper<AuditTrail> getBasicMapper() throws Exception {
		// TODO Auto-generated method stub
		return auditTrailMapper;
	}
	
}
