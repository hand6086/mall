package com.hand.core.autoconfig.service;

import java.util.Map;

import com.hand.base.basic.service.BasicService;
import com.hand.core.autoconfig.model.LnkInnerObject;

public interface LnkInnerObjectService extends BasicService<LnkInnerObject> {
	
	/**
	 * 
	 *<p>生成建表语句</p>
	 * @author huanganbang、yrf
	 * @param record
	 * @return
	 * @throws Exception
	 */
	public String newTable(LnkInnerObject record) throws Exception;
	
	/**
	 * 
	 *<p>生成查询Sql语句</p>
	 * @author huanganbang、yrf
	 * @param record
	 * @return
	 * @throws Exception
	 */
	public String newQueryTable(LnkInnerObject record) throws Exception;
	
	/**
	 * 
	 *<p>生成工程对象</p>
	 * @author yrf
	 * @param record
	 * @return
	 * @throws Exception
	 */
	public Map<String, String> newObjectFile(LnkInnerObject record) throws Exception;
	/**
	 * 
	 *<p>生成移动端工程对象</p>
	 * @author yrf
	 * @param record
	 * @return
	 * @throws Exception
	 */
	public Map<String, String> newAppFile(LnkInnerObject record) throws Exception;
	
	public String Check(LnkInnerObject record) throws Exception;
	
	public void DeepCopy(LnkInnerObject record) throws Exception;
	
	public void getmodelinfo(LnkInnerObject record) throws Exception;
	
	public void updatemodelinfo(LnkInnerObject record) throws Exception;

	/**
	 * 
	 *<p>获取完整配置对象信息</p>
	 * @author yrf
	 * @param record
	 * @return
	 * @throws Exception
	 */
	public LnkInnerObject getFullLnkInnerObjectById(LnkInnerObject record) throws Exception;
	
	public String test(LnkInnerObject record) throws Exception;
}
