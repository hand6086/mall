package com.hand.base.tablemanage.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.model.BasicModel;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.platformfavorable.dao.mybatis.mapper.PlatformfavorableMapper;
import com.hand.base.platformfavorable.model.Platformfavorable;
import com.hand.base.tablemanage.dao.mybatis.mapper.tableManageMapper;
import com.hand.base.tablemanage.model.tableManage;
import com.hand.core.util.StringUtils;

@Service
public class tableManageServiceImpl extends BasicServiceImpl<tableManage>
		implements tableManageService {
	@Autowired
	private tableManageMapper tablemanageMapper;

	public BasicMapper<tableManage> getBasicMapper() throws Exception {
		if (tablemanageMapper != null) {
			return tablemanageMapper;
		}
		throw new BasicServiceException("获取Basic Mapper 失败，请确认程序是否正确！");
	}

	@Override
	public List<tableManage> queryFieldPage(tableManage t) throws Exception {
		// TODO Auto-generated method stub
		return tablemanageMapper.queryFieldPage(t);
	}

	@Override
	public void filedInsert(tableManage entity) throws Exception {
		// TODO Auto-generated method stub
		tablemanageMapper.filedInsert(entity);
	}

	@Override
	public void filedupdate(tableManage entity) throws Exception {
		// TODO Auto-generated method stub
		tablemanageMapper.filedupdate(entity);
	}

	@Override
	public void deletefiledId(tableManage entity) throws Exception {
		// TODO Auto-generated method stub
		tablemanageMapper.deletefiledId(entity);
		
	}

	

}
