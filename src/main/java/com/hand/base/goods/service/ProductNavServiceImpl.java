package com.hand.base.goods.service;

import com.hand.base.goods.dao.mybatis.mapper.ProductNavMapper;
import com.hand.base.goods.model.ProductNav;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductNavServiceImpl implements ProductNavService {

	@Autowired
	private ProductNavMapper productNavMapper;

	@Override
	public List<ProductNav> queryAll() throws Exception {
		return productNavMapper.queryAll();
	}
}
