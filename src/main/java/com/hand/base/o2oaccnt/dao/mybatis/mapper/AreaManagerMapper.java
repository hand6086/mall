package com.hand.base.o2oaccnt.dao.mybatis.mapper;

import java.util.List;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.o2oaccnt.model.AreaManager;
import com.hand.core.basic.query.QueryParams;

public interface AreaManagerMapper extends BasicMapper<AreaManager>{
	public List<AreaManager> organizationPickListPage(AreaManager record) throws Exception;
	/**
	 * 添加行政区域图片
	 * @param record
	 * @throws Exception
	 */
	public void areaImageUpate(AreaManager record) throws Exception;
}
