package com.hand.base.basic.dao.mybatis.mapper;

import java.util.List;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.model.ListOfValue;
import com.hand.base.basic.model.ListValue;

public interface BasicCommonMapper extends BasicMapper<ListOfValue>{
	
	
	/**
	 * 查询物流公司列表
	 * @param username 用户名
	 * @return 用户信息
	 */
	public List<ListValue> queryLogisticsCompany() throws Exception;
	
	/**
	 * 根据类型和独立源代码
	 * @param username 用户名
	 * @return 用户信息
	 */
	public ListOfValue queryLovByValAndType(ListOfValue entity) throws Exception;
	
	/**
	 * 根据类型和显示值查询
	 * @param entity
	 * @return
	 * @throws Exception
	 */
	public ListOfValue queryLovByNameAndType(ListOfValue entity) throws Exception;
	
	/**
	 * 
	 * @return
	 * @throws Exception
	 */
	public ListOfValue getLovName(ListOfValue entity) throws Exception;
	
	/**
	 * 
	 * @return
	 * @throws Exception
	 */
	public ListOfValue getLovVal(ListOfValue entity) throws Exception;
	
}