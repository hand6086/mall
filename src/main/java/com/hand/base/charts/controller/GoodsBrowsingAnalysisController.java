package com.hand.base.charts.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.service.BasicService;
import com.hand.base.charts.model.ChartsBrowsingAnalysis;
import com.hand.base.charts.service.GoodsBrowsingAnalysisService;

@Controller
@RequestMapping("/action/portal/goodsBrowsingAnalysis")
public class GoodsBrowsingAnalysisController extends BasicController<ChartsBrowsingAnalysis> {

	@Resource
	private GoodsBrowsingAnalysisService goodsBrowsingAnalysisService;

	@Override
	public BasicService<ChartsBrowsingAnalysis> getBasicService() throws Exception {
		return goodsBrowsingAnalysisService;
	}	 
}
