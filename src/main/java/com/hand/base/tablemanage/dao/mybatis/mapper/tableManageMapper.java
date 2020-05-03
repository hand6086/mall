package com.hand.base.tablemanage.dao.mybatis.mapper;

import java.util.List;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.platformfavorable.model.Platformfavorable;
import com.hand.base.tablemanage.model.tableManage;



public interface tableManageMapper extends BasicMapper<tableManage> {
	
	//第二个table的数据
	public List<tableManage> queryFieldPage(tableManage record)  throws Exception;

	public void filedInsert(tableManage entity)throws Exception;

	public void filedupdate(tableManage entity)throws Exception;

	public void deletefiledId(tableManage entity)throws Exception;

	}
