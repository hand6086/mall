package com.hand.base.doc.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.doc.dao.mybatis.mapper.LnkDocMenuLineMapper;
import com.hand.base.doc.model.LnkDocMenuLine;


	@Service
	public class LnkDocMenuLineServiceImpl  extends BasicServiceImpl<LnkDocMenuLine>implements LnkDocMenuLineService {

	@Resource
	private LnkDocMenuLineMapper	lnkDocMenuLineMapper;
	@Override
	public BasicMapper<LnkDocMenuLine> getBasicMapper() {
		return lnkDocMenuLineMapper;
	}
	@Override
	public List<LnkDocMenuLine> queryMenuLine(String s) throws Exception {
		return lnkDocMenuLineMapper.queryMenuLine(s);
	}
}
