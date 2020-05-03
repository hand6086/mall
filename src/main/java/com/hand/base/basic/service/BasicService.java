package com.hand.base.basic.service;

import java.util.List;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.core.basic.query.QueryParams;

public interface BasicService<T>{
	
	/**
	 * 获取基本数据层
	 * @throws Exception
	 */
	public BasicMapper<T> getBasicMapper() throws Exception;

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
	 * 新建多条记录
	 * @param list
	 * @throws Exception
	 */
	public void batchInsert(List<T> list) throws Exception;
	
	/**
	 * 新建默认值
	 */
	public T preDefaultValue(T entity) throws Exception;
	
	/**
	 * 新建后默认
	 */
	public T postDefaultValue(T entity) throws Exception;
	
	/**
	 * 新增或更新，通过row_status区分
	 * @param entity
	 * @throws Exception
	 */
	public void upsert(T entity) throws Exception;
	
	/**
	 * 新增或更新，通过row_status区分
	 * @param entity
	 * @throws Exception
	 */
	public void brandUpsert(T entity) throws Exception;
	
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
	 * 删除多条数据
	 * @param list
	 * @throws Exception
	 */
	public void batchDelete(List<T> list) throws Exception;
	
	/**
	 * 根据条件查询记录,不分页
	 * @param qps
	 * @return
	 */
	public List<T> queryAll(T entity) throws Exception;
	
	/**
	 * 根据条件查询记录,默认分页(若将'noPage'设置为'true'，则不分页)
	 * @param qps
	 * @return
	 */
	public List<T> queryByExamplePage(T entity) throws Exception;
	
	/**
	 * 根据条件查询记录,默认分页(若将'noPage'设置为'true'，则不分页)
	 * @param qps
	 * @return
	 */
	public List<T> brandQueryByExamplePage(T entity) throws Exception;
	
	/**
	 * 记录计数
	 * @param qps
	 * @return
	 */
	public int countByExample(T entity) throws Exception;
	
	/**
	 * 数据校验(可通过返回值或抛异常的方式使用)
	 * @return true(校验通过) or false(校验不通过)
	 * @throws Exception
	 */
	public boolean checkData(T entity) throws Exception;
	
	/**
	 * 查询所有记录前 或 根据条件查询记录前 做操作
	 */
	public void beforQueryAllOrExample(T entity) throws Exception;

	/**
	 * 查询所有记录前做操作
	 */
	public void beforQueryAll(T entity) throws Exception;

	/**
	 * 根据条件查询记录前做操作
	 */
	public void beforQueryExample(T entity) throws Exception;
	
	/**
	 * 更新前做操作
	 */
	public void beforUpdate(T entity) throws Exception;
	
	/**
	 * 品牌馆更新前做操作
	 */
	public void beforBrandUpdate(T entity) throws Exception;
	
	/**
	 * 更新后做操作
	 */
	public void afterUpdate(T entity) throws Exception;
	
	/**
	 * 插入前做操作
	 */
	public void beforInsert(T entity) throws Exception;
	
	/**
	 * 品牌馆插入前做操作
	 */
	public void beforBrandInsert(T entity) throws Exception;
	
	/**
	 * 删除前做操作
	 */
	public void beforDelete(T entity) throws Exception;
	
	/**
	 * 插入或更新前做操作
	 */
	public void beforUpsert(T entity) throws Exception;
	
	/**
	 * 品牌馆插入或更新前做操作
	 */
	public void beforBrandUpsert(T entity) throws Exception;
	
	/**
	 * 判断当前是否为插入操作
	 * @param entity 实体类
	 * @return true(插入) or false(更新)
	 * @throws Exception
	 */
	public boolean isInsertFlag(T entity) throws Exception;
	
	/**
	 * 
	 *<p>批量更新</p>
	 * @author yrf
	 * @param list
	 * @throws Exception
	 */
	public void batchUpdate(List<T> list) throws Exception;
	
	
	
	
	
	
	
	/* ---------------------------------- */
	/* 待删除代码 */
	/* 为了防止服务启动时报错，以下代码将暂时保留，等改为所有代码后，以下代码将全部删除 */
	public void batchNew(List<T> list) throws Exception;
	public T queryOne(T entity) throws Exception;
	public void insertOrUpdate(T entity) throws Exception;
	public void deleteById(String id) throws Exception;
	public T newDefaultValue() throws Exception;
	public List<T> queryListPage(QueryParams qps) throws Exception;
	public List<T> queryListSelect(QueryParams qps) throws Exception;
	/* ---------------------------------- */
	
}
