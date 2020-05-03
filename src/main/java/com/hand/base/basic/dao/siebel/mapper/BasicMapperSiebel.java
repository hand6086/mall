package com.hand.base.basic.dao.siebel.mapper;

import java.util.List;
/*
 * 微信公众号清楚缓存使用
 */
public interface BasicMapperSiebel<T> {
	/**
	 * 新建一条数据
	 * 
	 * @param entity
	 */
	public void insert(T entity) throws Exception;
	
	/**
	 * 更新一条数据
	 * 
	 * @param entity
	 */
	public void update(T entity) throws Exception;
	
	/**
	 * 查询一条数据
	 * 
	 * @param entity
	 * @return
	 * @throws Exception
	 */
	public T queryById(T entity) throws Exception;
	
	/**
	 * 删除一条数据
	 * 
	 * @param entity
	 */
	public void deleteById(T entity) throws Exception;
	
	/**
	 * 记录计数
	 * 
	 * @param entity
	 * @return
	 * @throws Exception
	 */
	public int countByExample(T entity) throws Exception;
	
	/**
	 * 查询所有
	 * 
	 * @param qps
	 * @return
	 */
	public List<T> queryAll(T entity) throws Exception;
	
	/**
	 * 根据条件查询记录
	 * 
	 * @param qps
	 * @return
	 */
	public List<T> queryByExamplePage(T entity) throws Exception;
}
