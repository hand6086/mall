package com.hand.core.autoconfig.service;

import java.util.List;

import com.hand.base.basic.model.ListOfValue;
import com.hand.base.basic.service.BasicService;
import com.hand.core.autoconfig.model.LnkInnerLink;
import com.hand.core.basic.query.QueryParams;

public interface LnkInnerLinkService extends BasicService<LnkInnerLink> {
	public List<ListOfValue> queryObjectLink(QueryParams qps) throws Exception;
}
