package com.hand.base.doc.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.doc.dao.mybatis.mapper.LnkDocParamMapper;
import com.hand.base.doc.model.LnkDocParam;


	@Service
	public class LnkDocParamServiceImpl  extends BasicServiceImpl<LnkDocParam>implements LnkDocParamService {

	@Resource
	private LnkDocParamMapper	lnkDocParamMapper;
	@Override
	public BasicMapper<LnkDocParam> getBasicMapper() {
		return lnkDocParamMapper;
	}
}
