package com.hand.base.charts.dao.mybatis.mapper;


import com.hand.base.charts.model.ChartsParam;

import java.util.List;
import java.util.Map;

import com.hand.base.basic.dao.mapper.BasicMapper;

public interface ChartsParamMapper extends BasicMapper<ChartsParam>{
	
	/**
	 * 批量插入参数
	 * @param list
	 * @throws Exception
	 */
	public void batchInsertChartsParam(List<ChartsParam> list) throws Exception;



	/**
	 * 根据创建人，报表Key，删除历史记录
	 * @param param
	 * @throws Exception
	 */
	public void historyDelete(Map<String, String> param)throws Exception;

	
	
}
