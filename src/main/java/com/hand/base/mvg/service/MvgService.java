package com.hand.base.mvg.service;

import java.util.HashMap;
import java.util.List;

import com.hand.base.mvg.model.Mvg;
import com.hand.base.basic.model.BasicModel;

public interface MvgService{

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
	 * 批量删除右列表数据
	 * @param entity
	 * @return 默认子ID
	 */
	public String batchDeleteById(List<Mvg> list) throws Exception;
	
	/**
	 * 删除右列表一条数据
	 * @param entity
	 */
	public void deleteById(Mvg entity) throws Exception;
	
	/**
	 * 批量插入数据到右列表
	 * @param list
	 * @return 默认子ID
	 * @throws Exception
	 */
	public String batchInsert(List<Mvg> list) throws Exception;
	
	/**
	 * 插入一条数据到右列表
	 * @param entity
	 */
	public void insert(Mvg entity) throws Exception;
	
	/**
	 * 查询默认ID
	 * @param entity
	 * @return 默认ID
	 */
	public String queryDefault(Mvg entity) throws Exception;
	
	/**
	 * 根据mapper名称获取对应bean的url
	 * @param mvgMapperName 启用的mapper名称
	 * @return
	 * @throws Exception
	 */
	public String getBeanName(String mvgMapperName) throws Exception;
	
	/**
	 * 获取正在启用的mapper的名称
	 */
	public String getMvgMapperName();

	/**
	 * 设置mapper名称，根据名称来启用mapper
	 * @param mapperName
	 */
	public void setMvgMapperName(String mapperName);
}
