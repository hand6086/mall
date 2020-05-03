package com.hand.base.basic.service;

import java.lang.reflect.Method;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.dao.siebel.mapper.BasicMapperSiebel;
import com.hand.base.basic.model.BasicModel;
import com.hand.core.basic.query.QueryParams;
import com.hand.core.util.StringUtils;

public class BasicServiceImpl<T> implements BasicService<T>{
	
	@Autowired
	protected KeyGenerateService keyGenerateService;
	
	@Override
	public BasicMapper<T> getBasicMapper() throws Exception {
		throw new BasicServiceException("获取Basic Mapper 失败，请确认程序是否正确！");
	}
	/*
	 * 微信公众号清楚缓存使用
	 */
	public BasicMapperSiebel<T> getSiebelBasicMapper() throws Exception {
		return null;
	}

	@Override
	@Transactional
	public void insert(T entity) throws Exception {
		beforInsert(entity);
		beforUpsert(entity);
		postDefaultValue(entity);//设置默认值
		BasicModel model  = (BasicModel) entity;
		if(StringUtils.isBlank(model.getId())){
			model.setId(keyGenerateService.keyGenerate());
		}
		if(!checkData(entity)){//进行数据校验
			throw new BasicServiceException("校验不通过，请检查数据！");
		}
		getBasicMapper().insert(entity);
	}
	
	@Override
	@Transactional
	public void brandInsert(T entity) throws Exception {
		beforBrandInsert(entity);
		beforBrandUpsert(entity);
		postDefaultValue(entity);//设置默认值
		BasicModel model  = (BasicModel) entity;
		if(StringUtils.isBlank(model.getId())){
			model.setId(keyGenerateService.keyGenerate());
		}
		if(!checkData(entity)){//进行数据校验
			throw new BasicServiceException("校验不通过，请检查数据！");
		}
		getBasicMapper().brandInsert(entity);
	}

	@Override
	@Transactional
	public void batchInsert(List<T> list) throws Exception {
		for(int i =0;list != null && i < list.size();i++){
			insert(list.get(i));
		}
	}
	
	@Override
	@Transactional
	public T preDefaultValue(T entity) throws Exception {
		BasicModel model  = new BasicModel();
		model.setId(keyGenerateService.keyGenerate());
		T newEntity = (T) model;
		return newEntity;
	}
	
	@Override
	@Transactional
	public T postDefaultValue(T entity) throws Exception {
		return entity;
	}
	
	@Override
	@Transactional
	public void upsert(T entity) throws Exception {
		if(isInsertFlag(entity)){
			insert(entity);
		}else{
			update(entity);
		}
	}
	
	@Override
	@Transactional
	public void brandUpsert(T entity) throws Exception {
		if(isInsertFlag(entity)){
			brandInsert(entity);
		}else{
			brandUpdate(entity);
		}
	}

	@Override
	@Transactional
	public void update(T entity) throws Exception {
		beforUpdate(entity);
		beforUpsert(entity);
		if(!checkData(entity)){//进行数据校验
			throw new BasicServiceException("校验不通过，请检查数据！");
		}
		checkId(entity);
		getBasicMapper().update(entity);
		afterUpdate(entity);
	}
	
	@Override
	@Transactional
	public void brandUpdate(T entity) throws Exception {
		beforBrandUpdate(entity);
		beforBrandUpsert(entity);
		if(!checkData(entity)){//进行数据校验
			throw new BasicServiceException("校验不通过，请检查数据！");
		}
		checkId(entity);
		getBasicMapper().brandUpdate(entity);
		afterUpdate(entity);
	}

	@Override
	public T queryById(T entity) throws Exception {
		checkId(entity);
		return getBasicMapper().queryById(entity);
	}
	
	@Override
	public T brandQueryById(T entity) throws Exception {
		checkId(entity);
		return getBasicMapper().brandQueryById(entity);
	}

	@Override
	@Transactional
	public void deleteById(T entity) throws Exception {
		beforDelete(entity);
		checkId(entity);
		getBasicMapper().deleteById(entity);
	}
	
	@Override
	@Transactional
	public void batchDelete(List<T> list) throws Exception {
		for(int i =0;list != null && i < list.size();i++){
			deleteById(list.get(i));
		}
	}

	@Override
	public List<T> queryAll(T entity) throws Exception {
		beforQueryAll(entity);
		beforQueryAllOrExample(entity);
		return getBasicMapper().queryAll(entity);
	}

	@Override
	public List<T> queryByExamplePage(T entity) throws Exception {
		beforQueryExample(entity);
		beforQueryAllOrExample(entity);
		return getBasicMapper().queryByExamplePage(entity);
	}
	
	@Override
	public List<T> brandQueryByExamplePage(T entity) throws Exception {
		beforQueryExample(entity);
		beforQueryAllOrExample(entity);
		return getBasicMapper().brandQueryByExamplePage(entity);
	}
	
	@Override
	public int countByExample(T entity) throws Exception {
		Method setOnlyCountFlag = entity.getClass().getMethod("setOnlyCountFlag", new Class[] { Boolean.class });
		setOnlyCountFlag.invoke(entity, true);
		T t = getBasicMapper().queryByExamplePage(entity).get(0);
		if(t instanceof BasicModel){
			return ((BasicModel) t).getTotal();
		}
		return -1;
		//return getBasicMapper().countByExample(entity);
	}
	
	@Override
	public boolean isInsertFlag(T entity) throws Exception{
		BasicModel basicModel = (BasicModel) entity;
		String statusFlag = basicModel.getRow_status();
		if(StringUtils.equals(statusFlag, "NEW")){
			return true;
		}
		else if(StringUtils.equals(statusFlag, "UPDATE")){
			return false;
		}
		else {
			throw new BasicServiceException("无法识别当前操作状态。");
		}
	}
	
	@Override
	public boolean checkData(T entity) throws Exception {
		return true;
	}
	
	public void beforQueryAllOrExample(T entity) throws Exception{}

	@Override
	public void beforQueryAll(T entity) throws Exception{}

	@Override
	public void beforQueryExample(T entity) throws Exception{}
	
	@Override
	public void beforUpdate(T entity) throws Exception{}
	
	@Override
	public void beforBrandUpdate(T entity) throws Exception{}
	
	@Override
	public void afterUpdate(T entity) throws Exception{}
	
	@Override
	public void beforInsert(T entity) throws Exception{}
	
	@Override
	public void beforBrandInsert(T entity) throws Exception{}
	
	@Override
	public void beforDelete(T entity) throws Exception{}
	
	@Override
	public void beforUpsert(T entity) throws Exception{}
	
	@Override
	public void beforBrandUpsert(T entity) throws Exception{}
	
	/**
	 * 校验ID是否为空，如果为空则抛出异常
	 * @param entity
	 * @throws Exception
	 */
	public void checkId(T entity) throws Exception {
		BasicModel basicMode = (BasicModel) entity;
		if(StringUtils.isBlank(basicMode.getId())){
			throw new BasicServiceException("Id不能为空！");
		}
	}
	
	@Override
	@Transactional
	public void batchUpdate(List<T> list) throws Exception {
		if(list != null){
			T record = null;
			for(int i=0; i<list.size(); i++){
				record = list.get(i);
				update(record);
			}
		}
	}
	
	
	
	
	
	
	
	
	
	
	
	
	

	/* ---------------------------------- */
	/* 待删除代码 */
	/* 为了防止服务启动时报错，以下代码将暂时保留，等改为所有代码后，以下代码将全部删除 */
	@Override
	@Transactional
	public void batchNew(List<T> list) throws Exception {
		throw new BasicServiceException("batchNew 该方法已停用，赶紧检查代码！");
	}
	@Override
	public T queryOne(T entity) throws Exception {
		throw new BasicServiceException("queryOne 该方法已停用，赶紧检查代码！");
	}
	public void deleteById(String id) throws Exception {
		throw new BasicServiceException("deleteById(String) 该方法已停用，赶紧检查代码！");
	}
	public List<T> queryListPage(QueryParams qps) throws Exception {
		throw new BasicServiceException("queryListPage 该方法已停用，赶紧检查代码！");
	}
	public List<T> queryListSelect(QueryParams qps) throws Exception {
		throw new BasicServiceException("queryListSelect 该方法已停用，赶紧检查代码！");
	}
	public T newDefaultValue() throws Exception {
		throw new BasicServiceException("newDefaultValue 该方法已停用，赶紧检查代码！");
	}
	public void insertOrUpdate(T entity) throws Exception {
		throw new BasicServiceException(" insertOrUpdate该方法已停用，赶紧检查代码！");
	}
	/* ---------------------------------- */


}
