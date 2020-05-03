package com.hand.base.charts.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.service.BasicService;
import com.hand.base.charts.model.BrandMerchOrderCloseStatistics;
import com.hand.base.charts.service.BrandMerchOrderCloseStatisticsService;

@Controller
@RequestMapping("/action/portal/brandMerchOrderCloseStatistics")
public class BrandMerchOrderCloseStatisticsController extends BasicController<BrandMerchOrderCloseStatistics> {

	@Resource
	private BrandMerchOrderCloseStatisticsService brandMerchOrderCloseStatisticsService;

	@Override
	public BasicService<BrandMerchOrderCloseStatistics> getBasicService() throws Exception {
		return brandMerchOrderCloseStatisticsService;
	}	 
}
