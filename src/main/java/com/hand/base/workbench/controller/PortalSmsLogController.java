package com.hand.base.workbench.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.service.BasicService;
import com.hand.base.workbench.model.SmsLog;
import com.hand.base.workbench.service.SmsLogService;

@Controller
@RequestMapping("/action/portal/smsLog")
public class PortalSmsLogController extends BasicController<SmsLog> {
	@Autowired
	private SmsLogService smsLogService;
    
	@Override
	public BasicService<SmsLog> getBasicService() throws Exception {
			return smsLogService;
	}
	
}
