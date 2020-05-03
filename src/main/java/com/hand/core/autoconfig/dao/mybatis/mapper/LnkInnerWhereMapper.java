package com.hand.core.autoconfig.dao.mybatis.mapper;

import java.util.List;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.model.ListOfValue;
import com.hand.core.autoconfig.model.LnkInnerWhere;
import com.hand.core.basic.query.QueryParams;

public interface LnkInnerWhereMapper extends BasicMapper<LnkInnerWhere> {
	public List<ListOfValue> queryObjectWhere(QueryParams qps) throws Exception;
	
	public List<LnkInnerWhere> queryByInner(LnkInnerWhere record) throws Exception;
}
