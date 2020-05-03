package com.hand.base.workbench.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.service.BasicService;
import com.hand.base.workbench.model.SmsSend;
import com.hand.base.workbench.service.SmsLotService;

@Controller
@RequestMapping("/action/portal/smsLot")
public class PortalSmsLotController extends BasicController<SmsSend> {
	@Autowired
	private SmsLotService smsLotService;
    
	@Override
	public BasicService<SmsSend> getBasicService() throws Exception {
		return smsLotService;
	}
}
