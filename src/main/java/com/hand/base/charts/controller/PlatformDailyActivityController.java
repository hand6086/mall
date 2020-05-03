package com.hand.base.charts.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.service.BasicService;
import com.hand.base.charts.model.PlatformDailyActivity;
import com.hand.base.charts.service.PlatformDailyActivityService;

@Controller
@RequestMapping("/action/portal/platformDailyActivity")
public class PlatformDailyActivityController extends BasicController<PlatformDailyActivity> {

	@Resource
	private PlatformDailyActivityService plDailyActivityService;

	@Override
	public BasicService<PlatformDailyActivity> getBasicService() throws Exception {
		return plDailyActivityService;
	}	 
}
