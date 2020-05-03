package com.hand.base.params.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.controller.BasicControllerException;
import com.hand.base.basic.service.BasicService;
import com.hand.base.params.model.SystemConfiguration;
import com.hand.base.params.service.SystemConfigurationService;

@Controller
@RequestMapping("/action/portal/params/systemConfiguration")
public class SystemConfigurationController extends BasicController<SystemConfiguration> {

	@Autowired
	private SystemConfigurationService systemConfigurationService;

	@Override
	public BasicService<SystemConfiguration> getBasicService() throws Exception {
		if (systemConfigurationService != null) {
			return systemConfigurationService;
		}
		throw new BasicControllerException("获取Basic Service 失败，请确认程序代码是否正确！");
	}

}
