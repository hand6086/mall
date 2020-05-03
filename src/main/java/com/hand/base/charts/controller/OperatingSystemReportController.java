package com.hand.base.charts.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.KeyGenerateService;
import com.hand.base.charts.model.OperatingSystemReport;
import com.hand.base.charts.service.OperatingSystemReportService;
@Controller
@RequestMapping("/action/portal/opersystem")
public class OperatingSystemReportController extends BasicController<OperatingSystemReport> {
	@Resource
	private KeyGenerateService keyGenerateService;

	@Resource
	private OperatingSystemReportService opSystemService;

	@Override
	public BasicService<OperatingSystemReport> getBasicService() throws Exception {
		return opSystemService;
	}	 
}
