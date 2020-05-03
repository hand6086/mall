package com.hand.base.charts.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.service.BasicService;
import com.hand.base.charts.model.BrandMerchOrderPaymentStatistics;
import com.hand.base.charts.service.BrandMerchOrderPaymentStatisticsService;

@Controller
@RequestMapping("/action/portal/brandMerchOrderPaymentStatistics")
public class BrandMerchOrderPaymentStatisticsController extends BasicController<BrandMerchOrderPaymentStatistics> {

	@Resource
	private BrandMerchOrderPaymentStatisticsService brandMerchOrderPaymentStatisticsService;

	@Override
	public BasicService<BrandMerchOrderPaymentStatistics> getBasicService() throws Exception {
		return brandMerchOrderPaymentStatisticsService;
	}	 
}
