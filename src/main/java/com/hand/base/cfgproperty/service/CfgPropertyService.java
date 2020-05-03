package com.hand.base.cfgproperty.service;

import com.hand.base.basic.service.BasicService;
import com.hand.base.cfgproperty.model.CfgProperty;

public interface CfgPropertyService extends BasicService<CfgProperty>{

	/**
	 * 
	 *<p>从数据读取系统配置参数</p>
	 * @author yrf
	 * @param qps
	 * @throws Exception
	 */
	public void loadCfg(CfgProperty cfgProperty) throws Exception;
}
