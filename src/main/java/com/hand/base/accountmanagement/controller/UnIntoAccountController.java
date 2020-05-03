package com.hand.base.accountmanagement.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hand.base.accountmanagement.model.PayInfo;
import com.hand.base.accountmanagement.service.UnIntoAccountService;
import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.KeyGenerateService;

@Controller
@RequestMapping("/action/portal/unintoaccount")
public class UnIntoAccountController extends BasicController<PayInfo>{
	@Resource
	private KeyGenerateService keyGenerateService;

	@Resource
	private UnIntoAccountService unIntoAccountService;

	@Override
	public BasicService<PayInfo> getBasicService() throws Exception {
		return unIntoAccountService;
	}
}
