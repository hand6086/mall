package com.hand.base.order.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.order.dao.mybatis.mapper.CancelPermissionMapper;
import com.hand.base.order.model.CancelPermission;

@Service
public class CancelPermissionServiceImpl extends BasicServiceImpl<CancelPermission> implements CancelPermissionService {
	
	@Autowired
	private CancelPermissionMapper cancelPermissionMapper;

	@Override
	public BasicMapper<CancelPermission> getBasicMapper() {
		return cancelPermissionMapper;
	}

	@Override
	public List<CancelPermission> queryProductOrderPage(CancelPermission cancelPermission) throws Exception {
		return cancelPermissionMapper.queryProductOrderPage(cancelPermission);
	}
	
	@Override
	public int querycancelPermissionCount(CancelPermission entity) throws Exception {
		return cancelPermissionMapper.querycancelPermissionCount(entity);
	}
}
