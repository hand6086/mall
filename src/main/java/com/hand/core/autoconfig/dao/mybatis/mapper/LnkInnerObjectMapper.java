package com.hand.core.autoconfig.dao.mybatis.mapper;

import java.util.List;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.core.autoconfig.model.LnkInnerObject;

public interface LnkInnerObjectMapper extends BasicMapper<LnkInnerObject> {
	public List<LnkInnerObject> queryByInner(LnkInnerObject record) throws Exception;
}
