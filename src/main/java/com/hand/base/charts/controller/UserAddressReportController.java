package com.hand.base.charts.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.KeyGenerateService;
import com.hand.base.charts.model.UserAddressReport;
import com.hand.base.charts.service.UserAddressReportService;

@Controller
@RequestMapping("/action/portal/useraddress")
public class UserAddressReportController extends BasicController<UserAddressReport>{
	@Resource
	private KeyGenerateService keyGenerateService;

	@Resource
	private UserAddressReportService userAddressReportService;

	@Override
	public BasicService<UserAddressReport> getBasicService() throws Exception {
		return userAddressReportService;
	}	 
}
