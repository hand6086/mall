package com.hand.base.goods.service;

import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.common.model.Image;
import com.hand.base.goods.model.Goods;
import com.hand.base.goods.model.Product;

import java.util.List;


public interface ProductService extends BasicService<Product> {

    List<Product> queryList(Product record) throws Exception;

    Integer queryListCount(Product record) throws Exception;
	
	
}
