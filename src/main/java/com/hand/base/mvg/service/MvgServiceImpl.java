package com.hand.base.mvg.service;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hand.base.mvg.dao.mybatis.basic.mapper.MvgMapper;
import com.hand.base.mvg.model.Mvg;
import com.hand.base.basic.controller.BasicControllerException;
import com.hand.base.basic.dao.KeyGenerateDao;
import com.hand.base.basic.model.BasicModel;
import com.hand.core.basic.query.Filter;
import com.hand.core.basic.query.QueryParams;
import com.hand.core.util.StringUtils;

@Service
public class MvgServiceImpl extends MvgMapperBeen implements MvgService{

	public MvgMapper mvgMapper;
	private String mvgMapperName;//启用的mapper名称
	@Autowired
	private KeyGenerateDao keyGenerateDao;
	
	public List<HashMap<String, String>> queryLeftListPage(BasicModel entity) throws Exception {
		return getMvgMapper().queryLeftListPage(entity);
	}
	
	public List<HashMap<String, String>> queryRightListPage(BasicModel entity) throws Exception {
		return getMvgMapper().queryRightListPage(entity);
	}
	
	public void insert(Mvg entity) throws Exception {
		if(StringUtils.isBlank(entity.getMvgParentId())){
			throw new Exception("mvgParentId 不能为空！");
		}
		if(StringUtils.isBlank(entity.getMvgSubsetId())){
			throw new Exception("mvgSubsetId 不能为空！");
		}
		entity.setId(keyGenerateDao.keyGenerate());
		getMvgMapper().insert(entity);
	}
	
	@Override
	public String queryDefault(Mvg entity) throws Exception {
		String defMvgStId = null;
		QueryParams qps = new QueryParams();
		qps.addFilter(new Filter(entity.getDefField(), "Y"));
		BasicModel t = (BasicModel) BasicModel.transformClass(Class.forName(getBeanName(entity.getMvgMapperName())), qps);
		String conditionSql = t.getConditionSql();
		BeanUtils.copyProperties(entity, t);
		t.setConditionSql(conditionSql);
		t.setPageFlag(false);
		t.setTotalFlag(false);
		List list = queryRightListPage(t);
		if(list.size() == 1){
			defMvgStId = ((BasicModel)list.get(0)).getId();
		}
//		defMvgStId = getMvgMapper().queryDefault(entity);
		return defMvgStId;
	}

	@Transactional
	public String batchInsert(List<Mvg> list) throws Exception {
		String defMvgStId = null;
		if(list.get(0).getQueryDefaultFlag()){
			defMvgStId = queryDefault(list.get(0));
		}
		for(int i =0;list != null && i < list.size();i++){
			insert(list.get(i));
		}
		return defMvgStId;
	}
	
	@Transactional
	public String batchDeleteById(List<Mvg> list) throws Exception {
		String defMvgStId = null;
		if(list.get(0).getQueryDefaultFlag()){
			defMvgStId = queryDefault(list.get(0));
		}
		for(int i =0;list != null && i < list.size();i++){
			deleteById(list.get(i));
		}
		return defMvgStId;
	}

	public void deleteById(Mvg entity) throws Exception {
		if(StringUtils.isBlank(entity.getMvgParentId())){
			throw new Exception("mvgParentId 不能为空！");
		}
		if(StringUtils.isBlank(entity.getMvgSubsetId())){
			throw new Exception("mvgSubsetId 不能为空！");
		}
		getMvgMapper().deleteById(entity);
	}
	
	public void deleteAllById(Mvg entity) throws Exception {
		if(StringUtils.isBlank(entity.getMvgParentId())){
			throw new Exception("mvgParentId 不能为空！");
		}
		getMvgMapper().deleteAllById(entity);
	}

	/**
	 * 根据mapper名称，获取mapper实现类
	 * @return 得到的mapper实现类
	 */
	private MvgMapper getMvgMapper() throws Exception {
		if(StringUtils.isBlank(this.mvgMapperName)){
			throw new BasicControllerException("mvgMapperName名称不能为空，请检查程序！");
		}
		if(!this.mvgMapperName.contains("Mapper")){
			this.mvgMapperName = this.mvgMapperName + "MvgMapper";
		}
		Field property1 = this.getClass().getField(this.mvgMapperName);//根据名称获取目标mapper
		Field property2 = this.getClass().getField("mvgMapper");//获取当前的mapper
		property2.set(this,property1.get(this));//将目标mapper赋值给当前mapper
		return this.mvgMapper;
	}
	
	public String getBeanName(String mvgMapperName) throws Exception {
		String beanUrl = "";//查询参数(JavaBean)的全称
		if(StringUtils.isBlank(mvgMapperName)){
			throw new BasicControllerException("mvgMapperName名称不能为空，请检查程序！");
		}
		if(!mvgMapperName.contains("Mapper")){
			mvgMapperName = mvgMapperName + "MvgMapper";
		}
		String beanName = mvgMapperName.replace("Mapper", "Bean");
		Field beanField = this.getClass().getField(beanName);//根据名称获取bean的url
		beanUrl = beanField.getType().toString().replace("class ", "");//获取javaBean的名称
		return beanUrl;
	}

	public String getMvgMapperName() {
		return mvgMapperName;
	}

	public void setMvgMapperName(String mvgMapperName) {
		this.mvgMapperName = mvgMapperName;
	}

}
