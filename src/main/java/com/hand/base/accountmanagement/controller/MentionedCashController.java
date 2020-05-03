package com.hand.base.accountmanagement.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hand.base.accountmanagement.model.BillInfo;
import com.hand.base.accountmanagement.service.MentionedCashService;
import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.KeyGenerateService;

@Controller
@RequestMapping("/action/portal/mentionedcash")
public class MentionedCashController extends BasicController<BillInfo> {
	@Resource
	private KeyGenerateService keyGenerateService;

	@Resource
	private MentionedCashService mentionedCashService;

	@Override
	public BasicService<BillInfo> getBasicService() throws Exception {
		return mentionedCashService;
	}
}
