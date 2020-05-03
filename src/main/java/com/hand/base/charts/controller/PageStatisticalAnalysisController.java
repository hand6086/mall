package com.hand.base.charts.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.service.BasicService;
import com.hand.base.charts.model.ChartsBrowsingAnalysis;
import com.hand.base.charts.service.PageStatisticalAnalysisService;

@Controller
@RequestMapping("/action/portal/pageStatisticalAnalysis")
public class PageStatisticalAnalysisController extends BasicController<ChartsBrowsingAnalysis> {

	@Resource
	private PageStatisticalAnalysisService pageStatisticalAnalysisService;

	@Override
	public BasicService<ChartsBrowsingAnalysis> getBasicService() throws Exception {
		return pageStatisticalAnalysisService;
	}	 
}
