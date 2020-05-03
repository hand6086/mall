package com.hand.base.goods.service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.goods.dao.mybatis.mapper.CategoryMapper;
import com.hand.base.goods.model.Category;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CategoryServiceImpl extends BasicServiceImpl<Category>implements CategoryService {

	@Autowired
	private CategoryMapper categoryMapper;
	
	@Override
	public BasicMapper<Category> getBasicMapper(){
		return categoryMapper;
	}

	@Override
	public List<Category> queryAllCategory() {
		return categoryMapper.queryAllCategory();
	}
}
