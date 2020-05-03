package com.hand.base.urlinfo.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import com.hand.base.urlinfo.dao.mybatis.mapper.UrlDutyLinkMapper;
import com.hand.base.urlinfo.model.UrlDutyLink;
import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;


	@Service
	public class UrlDutyLinkServiceImpl  extends BasicServiceImpl<UrlDutyLink>implements UrlDutyLinkService {

	@Resource
	private UrlDutyLinkMapper	urlDutyLinkMapper;
	@Override
	public BasicMapper<UrlDutyLink> getBasicMapper() {
		return urlDutyLinkMapper;
	}
}