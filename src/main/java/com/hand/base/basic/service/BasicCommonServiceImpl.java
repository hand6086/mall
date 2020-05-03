package com.hand.base.basic.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.dao.mybatis.mapper.BasicCommonMapper;
import com.hand.base.basic.model.ListOfValue;

@Service
public class BasicCommonServiceImpl extends BasicServiceImpl<ListOfValue> implements BasicCommonService{

	@Autowired
	private BasicCommonMapper basicCommonMapper;
	
	@Override
	public BasicMapper<ListOfValue> getBasicMapper(){
		return basicCommonMapper;
	}

	@Override
	public ListOfValue preDefaultValue(ListOfValue entity) throws Exception {
		ListOfValue record = new ListOfValue( );
		record.setLangId("CHS");
		record.setActiveFlag("Y");
		record.setCorpid(record.getUsercorpid());
		return record;
	}
	
	public ListOfValue getLovByNameAndType(String stype, String val) throws Exception{
		ListOfValue entity = new ListOfValue();
		entity.setVal(val);
		entity.setType(stype);
		return basicCommonMapper.queryLovByValAndType(entity);
	}

	public ListOfValue getLovName(ListOfValue entity) throws Exception {
		return basicCommonMapper.getLovName(entity);
	}

	public ListOfValue getLovVal(ListOfValue entity) throws Exception {
		return basicCommonMapper.getLovVal(entity);
	}
	
	public String getLovVal(String type,String name) throws Exception {
		ListOfValue example = new ListOfValue();
		example.setLang("chs");
		example.setName(name);
		example.setType(type);
		ListOfValue result = basicCommonMapper.getLovVal(example);
		return result.getVal();
	}
	
}
