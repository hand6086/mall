package com.hand.base.basic.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mybatis.mapper.BasicCommonMapper;
import com.hand.base.basic.model.ListOfValue;

@Service
public class LovServiceImpl implements LovService{

	@Autowired
	private BasicCommonMapper basicCommonMapper;
	
	
	public ListOfValue getLovByNameAndType(String type,String val) throws BasicServiceException {
		
		ListOfValue record = new ListOfValue();
		record.setVal(val);
		record.setType(type);
		try {
			return basicCommonMapper.queryLovByValAndType(record);
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
	}


	@Override
	public String getLovValue(String type, String name) throws Exception {
		ListOfValue record = new ListOfValue();
		record.setName(name);
		record.setType(type);
		try {
			ListOfValue result =  basicCommonMapper.queryLovByNameAndType(record);
			if(result == null){
				throw new BasicServiceException("查询值列表【"+type+"】显示值为【"+name+"】的值失败！请稍后再试！");
			}
			return result.getVal();
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
	}


	@Override
	public String getLovName(String type, String value) throws Exception {
		ListOfValue record = new ListOfValue();
		record.setVal( value);
		record.setType(type);
		try {
			ListOfValue result =  basicCommonMapper.queryLovByValAndType(record);
			if(result == null){
				throw new BasicServiceException("查询值列表【"+type+"】独立源代码为【"+value+"】的值失败！请稍后再试！");
			}
			return result.getName();
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
	}

}
