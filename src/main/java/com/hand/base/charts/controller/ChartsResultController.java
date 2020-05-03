package com.hand.base.charts.controller;



import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hand.base.charts.model.ChartsResult;
import com.hand.base.charts.service.ChartsResultService;
import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.KeyGenerateService;

@Controller("ChartsController")
@RequestMapping("/action/portal/charts")
public class ChartsResultController extends BasicController<ChartsResult>{
 
	@Resource
	private KeyGenerateService keyGenerateService;

	@Resource
	private ChartsResultService chartsResultService;

	@Override
	public BasicService<ChartsResult> getBasicService() throws Exception {
		return chartsResultService;
	}	 
}
