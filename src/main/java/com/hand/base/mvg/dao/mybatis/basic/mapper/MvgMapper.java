package com.hand.base.mvg.dao.mybatis.basic.mapper;

import java.util.HashMap;
import java.util.List;

import com.hand.base.mvg.model.Mvg;
import com.hand.base.basic.model.BasicModel;
//import com.hand.core.mybatis.MyBatisRepository;

//@MyBatisRepository
public interface MvgMapper{
	
	/**
	 * 分页查询左列表
	 * @param entity
	 * @return
	 */
	public List<HashMap<String, String>> queryLeftListPage(BasicModel entity) throws Exception;
	
	/**
	 * 分页查询右列表
	 * @param entity
	 * @return
	 */
	public List<HashMap<String, String>> queryRightListPage(BasicModel entity) throws Exception;
	/**
	 * 删除右列表所有数据
	 * @param entity
	 */
	public void deleteAllById(Mvg entity) throws Exception;
	
	/**
	 * 删除一条数据
	 * @param entity
	 */
	public void deleteById(Mvg entity) throws Exception;
	
	/**
	 * 新建一条数据
	 * @param entity
	 */
	public void insert(Mvg entity) throws Exception;
	
	/**
	 * 查询默认ID
	 * @param entity
	 * @return 默认ID
	 */
	public String queryDefault(Mvg entity) throws Exception;
}
