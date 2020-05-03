package com.hand.base.doc.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.doc.dao.mybatis.mapper.LnkDocResultMapper;
import com.hand.base.doc.model.LnkDocResult;


	@Service
	public class LnkDocResultServiceImpl  extends BasicServiceImpl<LnkDocResult>implements LnkDocResultService {

	@Resource
	private LnkDocResultMapper	lnkDocResultMapper;
	@Override
	public BasicMapper<LnkDocResult> getBasicMapper() {
		return lnkDocResultMapper;
	}
}
