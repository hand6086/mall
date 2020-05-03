package com.hand.base.o2oaccnt.dao.mybatis.mapper;

import java.util.List;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.o2oaccnt.model.Area;

public interface AreaMapper extends BasicMapper<Area> {

	public List<Area> parentAreaPickListPage(Area record) throws Exception;
	public List<Area> actualCityPickListPage(Area record) throws Exception;
	/**
	 * 添加行政区域图片
	 * @param record
	 * @throws Exception
	 */
	public void areaImageUpate(Area record) throws Exception;
	
}
