package com.hand.base.goods.dao.mybatis.mapper;


import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.goods.model.Category;

import java.util.List;

public interface CategoryMapper extends BasicMapper<Category> {

    List<Category> queryAllCategory();

}
