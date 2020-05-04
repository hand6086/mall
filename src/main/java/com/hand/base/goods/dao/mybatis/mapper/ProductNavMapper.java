package com.hand.base.goods.dao.mybatis.mapper;

import com.hand.base.goods.model.ProductNav;

import java.util.List;

public interface ProductNavMapper {

    List<ProductNav> queryAll() throws Exception;

}