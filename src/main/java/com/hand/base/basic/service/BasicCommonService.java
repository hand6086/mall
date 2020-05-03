package com.hand.base.basic.service;

import com.hand.base.basic.model.ListOfValue;


public interface BasicCommonService extends BasicService<ListOfValue> {
	
	/**
	 * 根据值列列表类型和独立源代码找指列表
	 * @param val   用户名
	 * @param stype 类型
	 * @return 值列表信息
	 */
	public ListOfValue getLovByNameAndType(String val,String stype) throws Exception;
	
	/**
	 * 
	 * @return
	 * @throws Exception
	 */
	public ListOfValue getLovName(ListOfValue record) throws Exception;
	
	/**
	 * 
	 * @return
	 * @throws Exception
	 */
	public ListOfValue getLovVal(ListOfValue record) throws Exception;
	
	/**
	 * 
	 * @return
	 * @throws Exception
	 */
	public String getLovVal(String type,String name) throws Exception;
	
}
