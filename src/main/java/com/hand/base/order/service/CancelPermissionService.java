package com.hand.base.order.service;

import java.util.List;

import com.hand.base.basic.service.BasicService;
import com.hand.base.order.model.CancelPermission;

public interface CancelPermissionService extends BasicService<CancelPermission> {
	
	public List<CancelPermission> queryProductOrderPage(CancelPermission cancelPermission) throws Exception;
	
	public int querycancelPermissionCount(CancelPermission entity) throws Exception;
}
