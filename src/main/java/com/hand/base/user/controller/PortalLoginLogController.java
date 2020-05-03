package com.hand.base.user.controller;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.service.BasicService;
import com.hand.base.user.model.LoginLog;
import com.hand.base.user.service.LoginLogService;

@Controller
@RequestMapping("action/portal/loginlog")
public class PortalLoginLogController extends BasicController<LoginLog> {
	private static final Logger logger = LogManager.getLogger(PortalLoginLogController.class);
	@Resource
	private LoginLogService loginLogService;

	@Override
	public BasicService<LoginLog> getBasicService() throws Exception {
		return loginLogService;
	}
	
	
}
