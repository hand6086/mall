package com.hand.core.autoconfig.service;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.core.autoconfig.dao.mybatis.mapper.LnkInnerFieldMapper;
import com.hand.core.autoconfig.model.LnkInnerField;

@Service
public class LnkInnerFieldServiceImpl extends BasicServiceImpl<LnkInnerField>implements LnkInnerFieldService {
	@Resource
	private LnkInnerFieldMapper lnkInnerFieldMapper;
	
	@Override
	public BasicMapper<LnkInnerField> getBasicMapper() {
		return lnkInnerFieldMapper;
	}
	
	@Override
	public void beforUpdate(LnkInnerField entity) throws Exception{
		
	}
	
	@Override
	public void beforInsert(LnkInnerField entity) throws Exception{}
	
	@Override
	public void beforUpsert(LnkInnerField entity) throws Exception{
		String fieldName = entity.getName();//映射到java的javaBean字段名称
		String columnName = entity.getColumnname();//数据库列名
		if(StringUtils.isBlank(fieldName)){
			throw new BasicServiceException("字段名称不能为空");
		}
		fieldName = fieldName.replaceAll("\\s", "");
		char[] chars = fieldName.toCharArray();  
		chars[0] = toLowerCase(chars[0]);  
		fieldName = String.valueOf(chars);  
		entity.setName(fieldName);//去除空格
		if(!StringUtils.isBlank(columnName)){
			entity.setColumnname(columnName.replaceAll("\\s", ""));
		}
	}
	
	public static char toLowerCase(char chars) {  
		 if (65 <= chars && chars <= 90) {  //大写字母
		        chars ^= 32;  //转换为小写
		    } 
		   return chars;  
		}  

}
