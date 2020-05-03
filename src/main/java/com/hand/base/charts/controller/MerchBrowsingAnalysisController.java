package com.hand.base.charts.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.service.BasicService;
import com.hand.base.charts.model.ChartsBrowsingAnalysis;
import com.hand.base.charts.service.MerchBrowsingAnalysisService;

@Controller
@RequestMapping("/action/portal/merchBrowsingAnalysis")
public class MerchBrowsingAnalysisController extends BasicController<ChartsBrowsingAnalysis> {

	@Resource
	private MerchBrowsingAnalysisService merchBrowsingAnalysisService;

	@Override
	public BasicService<ChartsBrowsingAnalysis> getBasicService() throws Exception {
		return merchBrowsingAnalysisService;
	}	 
}
