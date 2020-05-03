package com.hand.base.charts.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.service.BasicService;
import com.hand.base.charts.model.BrandMerchAfterSalesAnalysis;
import com.hand.base.charts.service.BrandMerchAfterSalesAnalysisService;

@Controller
@RequestMapping("/action/portal/brandMerchAfterSalesAnalysis")
public class BrandMerchAfterSalesAnalysisController extends BasicController<BrandMerchAfterSalesAnalysis> {

	@Resource
	private BrandMerchAfterSalesAnalysisService brandMerchAfterSalesAnalysisService;

	@Override
	public BasicService<BrandMerchAfterSalesAnalysis> getBasicService() throws Exception {
		return brandMerchAfterSalesAnalysisService;
	}	 
}
