package com.hand.base.charts.controller;



import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.KeyGenerateService;
import com.hand.base.charts.model.ChartsParam;
import com.hand.base.charts.service.ChartsParamService;

import com.hand.base.user.model.User;
import com.hand.core.util.UserUtil;



@Controller("ChartsParamController")
@RequestMapping("/action/portal/chartsParam")
public class ChartsParamController extends BasicController<ChartsParam>{
 
	@Resource
	private KeyGenerateService keyGenerateService;

	@Resource
	private ChartsParamService chartsParamService;
	
/*	@Resource
	private ChartsresultService chartsresultService;*/
	

	@Override
	public BasicService<ChartsParam> getBasicService() throws Exception {
		return chartsParamService;
	}	 
	
	@RequestMapping(value = "/repotInert", method = {RequestMethod.POST})
	public Map<String, Object> testPost(@RequestBody String[] array) throws IOException {
			Map<String, Object> result = new HashMap<String, Object>();
	try {List<ChartsParam> list = new ArrayList<ChartsParam>();
	
	User user = UserUtil.getUser(null);

	String  chartKey= keyGenerateService.keyGenerate();
		for(String arr : array){
			ChartsParam chartsparam =new ChartsParam();
			String[] s = arr.split(";");
			chartsparam.setParamKey(s[0]);
			chartsparam.setParamValue(s[1]);
			chartsparam.setCreatedBy(user.getId());
			chartsparam.setLastUpdatedBy(user.getId());
			list.add(chartsparam);
			
		}
		Map<String, String> map = new HashMap<String, String>();
		map.put("createdBy", user.getId());
		map.put("key", chartKey);
		chartsParamService.historyDelete(map);
		chartsParamService.batchInsertChartsParam(list);
		
		
		
		// 更加报表Key，和创建人查询报表结果表名称
		
		
		
		
		
		
		
		
		
		
		
		
		
		
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	
	    return result;
	}
}
