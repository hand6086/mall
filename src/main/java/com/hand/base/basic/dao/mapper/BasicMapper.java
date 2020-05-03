package com.hand.base.basic.dao.mapper;

import java.util.List;

import com.hand.core.basic.query.QueryParams;

public interface BasicMapper<T>{

	/**
	 * 新建一条数据
	 * @param entity
	 */
	public void insert(T entity) throws Exception;
	
	/**
	 * 新建一条数据
	 * @param entity
	 */
	public void brandInsert(T entity) throws Exception;
	
	/**
	 * 更新一条数据
	 * @param entity
	 */
	public void update(T entity) throws Exception;
	
	/**
	 * 更新一条数据
	 * @param entity
	 */
	public void brandUpdate(T entity) throws Exception;
	
	/**
	 * 查询一条数据
	 * @param entity
	 * @return
	 * @throws Exception
	 */
	public T queryById(T entity) throws Exception;
	
	/**
	 * 品牌馆 查询一条数据
	 * @param entity
	 * @return
	 * @throws Exception
	 */
	public T brandQueryById(T entity) throws Exception;

	/**
	 * 删除一条数据
	 * @param entity
	 */
	public void deleteById(T entity) throws Exception;
	
	/**
	 * 记录计数
	 * @param entity
	 * @return
	 * @throws Exception
	 */
	public int countByExample(T entity) throws Exception;
	
	/**
	 * 根据条件查询记录,不分页
	 * @param qps
	 * @return
	 */
	public List<T> queryAll(T entity) throws Exception;
	
	/**
	 * 根据条件查询记录,默认分页(若将'pageFlag'设置为'true'，则不分页)
	 * @param qps
	 * @return
	 */
	public List<T> queryByExamplePage(T entity) throws Exception;
	
	
	/**
	 * 根据条件查询记录,默认分页(若将'pageFlag'设置为'true'，则不分页)
	 * @param qps
	 * @return
	 */
	public List<T> brandQueryByExamplePage(T entity) throws Exception;
	
	
	
	
	
	
	/* ---------------------------------- */
	/* 待删除代码 */
	/* 为了防止服务启动时报错，以下代码将暂时保留，等改为所有代码后，以下代码将全部删除 */
	public T queryOne(T entity) throws Exception;
	public List<T> queryAllPage(T entity) throws Exception;
	public void deleteById(String id) throws Exception;
	public List<T> queryListPage(QueryParams qps) throws Exception;
	public List<T> queryListSelect(QueryParams qps) throws Exception;
	/* ---------------------------------- */

}
