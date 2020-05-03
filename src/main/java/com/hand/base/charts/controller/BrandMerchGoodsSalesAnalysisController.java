package com.hand.base.charts.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.service.BasicService;
import com.hand.base.charts.model.BrandMerchGoodsSalesAnalysis;
import com.hand.base.charts.service.BrandMerchGoodsSalesAnalysisService;

@Controller
@RequestMapping("/action/portal/brandMerchGoodsSalesAnalysis")
public class BrandMerchGoodsSalesAnalysisController extends BasicController<BrandMerchGoodsSalesAnalysis> {

	@Resource
	private BrandMerchGoodsSalesAnalysisService brandMerchGoodsSalesAnalysisService;

	@Override
	public BasicService<BrandMerchGoodsSalesAnalysis> getBasicService() throws Exception {
		return brandMerchGoodsSalesAnalysisService;
	}	 
}
