package com.hand.base.goods.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.goods.dao.mybatis.mapper.ProdNormsMapper;
import com.hand.base.goods.model.ProdNorms;


	@Service
	public class ProdNormsServiceImpl  extends BasicServiceImpl<ProdNorms>implements ProdNormsService {

	@Resource
	private ProdNormsMapper	prodNormsMapper;
	@Override
	public BasicMapper<ProdNorms> getBasicMapper() {
		return prodNormsMapper;
	}
}
