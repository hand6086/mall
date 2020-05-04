package com.hand.base.goods.dao.mybatis.mapper;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.goods.model.Product;

import java.util.List;

public interface ProductMapper extends BasicMapper<Product>{

    List<Product> queryList(Product record) throws Exception;

    Integer queryListCount(Product record) throws Exception;

}