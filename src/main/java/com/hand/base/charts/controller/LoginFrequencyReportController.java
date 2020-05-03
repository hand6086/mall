package com.hand.base.charts.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.KeyGenerateService;
import com.hand.base.charts.model.LoginFrequencyReport;
import com.hand.base.charts.service.LoginFrequencyReportService;
@Controller
@RequestMapping("/action/portal/loginfrequeny")
public class LoginFrequencyReportController extends BasicController<LoginFrequencyReport>{
	@Resource
	private KeyGenerateService keyGenerateService;

	@Resource
	private LoginFrequencyReportService loginFrequenyService;

	@Override
	public BasicService<LoginFrequencyReport> getBasicService() throws Exception {
		return loginFrequenyService;
	}	 
}
