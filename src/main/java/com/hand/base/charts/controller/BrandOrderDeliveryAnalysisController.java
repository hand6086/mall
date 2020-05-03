package com.hand.base.charts.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.service.BasicService;
import com.hand.base.charts.model.BrandOrderDeliveryAnalysis;
import com.hand.base.charts.service.BrandOrderDeliveryAnalysisService;

@Controller
@RequestMapping("/action/portal/brandOrderDeliveryAnalysis")
public class BrandOrderDeliveryAnalysisController extends BasicController<BrandOrderDeliveryAnalysis> {

	@Resource
	private BrandOrderDeliveryAnalysisService brandOrderDeliveryAnalysisService;

	@Override
	public BasicService<BrandOrderDeliveryAnalysis> getBasicService() throws Exception {
		return brandOrderDeliveryAnalysisService;
	}	 
}
