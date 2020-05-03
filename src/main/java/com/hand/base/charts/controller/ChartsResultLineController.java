package com.hand.base.charts.controller;



import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.KeyGenerateService;
import com.hand.base.charts.model.ChartsResultLine;
import com.hand.base.charts.service.ChartsResultLineService;

@Controller("ChartsresultController")
@RequestMapping("/action/portal/chartsresult")
public class ChartsResultLineController extends BasicController<ChartsResultLine>{
 
	@Resource
	private KeyGenerateService keyGenerateService;

	@Resource
	private ChartsResultLineService chartsResultLineService;

	@Override
	public BasicService<ChartsResultLine> getBasicService() throws Exception {
		return chartsResultLineService;
	}	 
}
