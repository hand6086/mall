package com.hand.base.charts.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.service.BasicService;
import com.hand.base.charts.model.PlatformBrandMerchDataStatistics;
import com.hand.base.charts.service.PlatformBrandMerchDataStatisticsService;

@Controller
@RequestMapping("/action/portal/platformBrandMerchDataStatistics")
public class PlatformBrandMerchDataStatisticsController extends BasicController<PlatformBrandMerchDataStatistics> {

	@Resource
	private PlatformBrandMerchDataStatisticsService platformBrandMerchDataStatisticsService;

	@Override
	public BasicService<PlatformBrandMerchDataStatistics> getBasicService() throws Exception {
		return platformBrandMerchDataStatisticsService;
	}	 
}
