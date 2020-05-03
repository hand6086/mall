package com.hand.base.o2oaccnt.controller;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.service.BasicService;
import com.hand.base.o2oaccnt.model.DealerAccount;
import com.hand.base.o2oaccnt.service.DealerAccountService;

@Controller()
@RequestMapping("/action/portal/dealerAccount")
public class DealerAccountController extends BasicController<DealerAccount> {
	
	private static final Logger logger = LogManager.getLogger(DealerAccountController.class);

	@Resource
	private DealerAccountService dealerAccountService;

	@Override
	public BasicService<DealerAccount> getBasicService() throws Exception {
		return dealerAccountService;
	}
}
