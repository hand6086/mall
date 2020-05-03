package com.hand.base.workbench.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.controller.BasicControllerException;
import com.hand.base.basic.service.BasicService;
import com.hand.base.workbench.model.o2oLoginLog;
import com.hand.base.workbench.service.o2oLoginLogService;

@Controller
@RequestMapping("/action/portal/o2oLoginLog")
public class Portalo2oLoginLogController extends BasicController<o2oLoginLog> {
	@Autowired
	private o2oLoginLogService o2oLoginLogService;
    
	@Override
	public BasicService<o2oLoginLog> getBasicService() throws Exception {
		return o2oLoginLogService;
	}
	
	
}
