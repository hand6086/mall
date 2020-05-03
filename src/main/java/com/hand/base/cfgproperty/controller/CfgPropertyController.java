package com.hand.base.cfgproperty.controller;


import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.controller.BasicControllerException;
import com.hand.base.basic.service.BasicService;
import com.hand.base.cfgproperty.model.CfgProperty;
import com.hand.base.cfgproperty.service.CfgPropertyService;
import com.hand.core.basic.query.QueryParams;

/**
 * 
 * <p>Title</p>
 * <p>系统运行参数配置</p>
 * <p>Company</p>
 * @author yrf
 * @date 2016年9月7日  下午5:19:42
 */
@Controller
@RequestMapping("/action/portal/cfgProperty")
public class CfgPropertyController extends BasicController<CfgProperty> {

	@Autowired
	private CfgPropertyService cfgPropertyService;
	
	public BasicService<CfgProperty> getBasicService() throws Exception{
		if(cfgPropertyService != null){
			return cfgPropertyService;
		}
		throw new BasicControllerException("获取Basic Service 失败，请确认程序代码是否正确！");
	}
	
	@RequestMapping("/loadCfg")
	@ResponseBody
	public Map<String, Object> loadCfg(CfgProperty entity, QueryParams qps){
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			cfgPropertyService.loadCfg(entity);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
}
