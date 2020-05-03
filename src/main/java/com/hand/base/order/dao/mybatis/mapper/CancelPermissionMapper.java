package com.hand.base.order.dao.mybatis.mapper;

import java.util.List;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.order.model.CancelPermission;

public interface CancelPermissionMapper extends BasicMapper<CancelPermission> {

	public List<CancelPermission> queryProductOrderPage(CancelPermission cancelPermission) throws Exception;

	public int querycancelPermissionCount(CancelPermission entity) throws Exception;
}
