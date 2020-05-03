package com.hand.base.charts.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.service.BasicService;
import com.hand.base.charts.model.ChartsBrowsingAnalysis;
import com.hand.base.charts.service.ActivityBrowsingAnalysisService;

@Controller
@RequestMapping("/action/portal/activityBrowsingAnalysis")
public class ActivityBrowsingAnalysisController extends BasicController<ChartsBrowsingAnalysis> {

	@Resource
	private ActivityBrowsingAnalysisService activityBrowsingAnalysisService;

	@Override
	public BasicService<ChartsBrowsingAnalysis> getBasicService() throws Exception {
		return activityBrowsingAnalysisService;
	}	 
}
