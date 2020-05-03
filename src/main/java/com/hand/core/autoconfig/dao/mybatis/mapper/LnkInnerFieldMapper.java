package com.hand.core.autoconfig.dao.mybatis.mapper;

import java.util.List;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.core.autoconfig.model.LnkInnerField;

public interface LnkInnerFieldMapper extends BasicMapper<LnkInnerField> {
	public List<LnkInnerField> queryByInner(LnkInnerField record) throws Exception;
}
