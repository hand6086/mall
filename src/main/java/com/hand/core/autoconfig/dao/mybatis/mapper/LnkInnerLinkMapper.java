package com.hand.core.autoconfig.dao.mybatis.mapper;

import java.util.List;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.model.ListOfValue;
import com.hand.core.autoconfig.model.LnkInnerLink;

public interface LnkInnerLinkMapper extends BasicMapper<LnkInnerLink> {
	public List<ListOfValue> queryObjectLink(LnkInnerLink record) throws Exception;
	
	public List<LnkInnerLink> queryByInner(LnkInnerLink record) throws Exception;
}
