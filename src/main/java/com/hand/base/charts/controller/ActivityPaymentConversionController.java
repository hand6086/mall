package com.hand.base.charts.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.service.BasicService;
import com.hand.base.charts.model.ActivityPaymentConversion;
import com.hand.base.charts.service.ActivityPaymentConversionService;

@Controller
@RequestMapping("/action/portal/activityPaymentConversion")
public class ActivityPaymentConversionController extends BasicController<ActivityPaymentConversion> {

	@Resource
	private ActivityPaymentConversionService activityPaymentConversionService;

	@Override
	public BasicService<ActivityPaymentConversion> getBasicService() throws Exception {
		return activityPaymentConversionService;
	}	 
}
