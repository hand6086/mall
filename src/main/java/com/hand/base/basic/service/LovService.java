package com.hand.base.basic.service;

import com.hand.base.basic.model.ListOfValue;


public interface LovService {
	
	/**
	 * 根据值列列表类型和独立源代码找指列表
	 * @param val   用户名
	 * @param stype 类型
	 * @return 值列表信息
	 */
	public ListOfValue getLovByNameAndType(String val,String stype)throws BasicServiceException;
	
	/**
	 * 根据值列表类型、显示值获取独立源代码
	 * @param type
	 * @param name
	 * @return
	 * @throws Exception
	 */
	public String getLovValue(String type,String name) throws Exception;
	
	/**
	 * 根据值列表类型、显示值获取显示值
	 * @param type
	 * @param Value
	 * @return
	 * @throws Exception
	 */
	public String getLovName(String type,String Value) throws Exception;
	
}
