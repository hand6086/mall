package com.hand.base.charts.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.service.BasicService;
import com.hand.base.charts.model.PlatformRepeatPurchase;
import com.hand.base.charts.service.PlatformRepeatPurchaseService;

@Controller
@RequestMapping("/action/portal/platformRepeatPurchase")
public class PlatformRepeatPurchaseController extends BasicController<PlatformRepeatPurchase> {

	@Resource
	private PlatformRepeatPurchaseService platformRepeatPurchaseService;

	@Override
	public BasicService<PlatformRepeatPurchase> getBasicService() throws Exception {
		return platformRepeatPurchaseService;
	}	 
}
