package com.hand.base.doc.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.doc.dao.mybatis.mapper.LnkDocMenuMapper;
import com.hand.base.doc.model.LnkDocMenu;


	@Service
	public class LnkDocMenuServiceImpl  extends BasicServiceImpl<LnkDocMenu>implements LnkDocMenuService {

	@Resource
	private LnkDocMenuMapper	lnkDocMenuMapper;
	@Override
	public BasicMapper<LnkDocMenu> getBasicMapper() {
		return lnkDocMenuMapper;
	}
}
