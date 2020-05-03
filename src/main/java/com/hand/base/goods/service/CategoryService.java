package com.hand.base.goods.service;

import com.hand.base.basic.service.BasicService;
import com.hand.base.goods.model.Category;

import java.util.List;


public interface CategoryService extends BasicService<Category> {

    List<Category> queryAllCategory();
	
}
