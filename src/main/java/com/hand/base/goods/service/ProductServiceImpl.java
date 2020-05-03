package com.hand.base.goods.service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.goods.dao.mybatis.mapper.ProductMapper;
import com.hand.base.goods.model.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ProductServiceImpl extends BasicServiceImpl<Product>implements ProductService {

	@Autowired
	private ProductMapper productMapper;
	
	@Override
	public BasicMapper<Product> getBasicMapper(){
		return productMapper;
	}

}
