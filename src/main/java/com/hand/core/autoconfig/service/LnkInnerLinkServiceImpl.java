package com.hand.core.autoconfig.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.model.BasicModel;
import com.hand.base.basic.model.ListOfValue;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.core.autoconfig.dao.mybatis.mapper.LnkInnerLinkMapper;
import com.hand.core.autoconfig.model.LnkInnerLink;
import com.hand.core.basic.query.QueryParams;

@Service
public class LnkInnerLinkServiceImpl extends BasicServiceImpl<LnkInnerLink>implements LnkInnerLinkService {
	@Resource
	private LnkInnerLinkMapper lnkInnerLinkMapper;
	
	public List<ListOfValue> queryObjectLink(QueryParams qps) throws Exception {
		LnkInnerLink lov = (LnkInnerLink) BasicModel.transformClass(LnkInnerLink.class, qps);
		return lnkInnerLinkMapper.queryObjectLink(lov);
	}
	
	@Override
	public BasicMapper<LnkInnerLink> getBasicMapper() {
		return lnkInnerLinkMapper;
	}
}
