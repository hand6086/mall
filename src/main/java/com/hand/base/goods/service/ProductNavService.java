package com.hand.base.goods.service;

import com.hand.base.basic.service.BasicService;
import com.hand.base.goods.model.Product;
import com.hand.base.goods.model.ProductNav;

import java.util.List;


public interface ProductNavService {

    List<ProductNav> queryAll() throws Exception;
}
