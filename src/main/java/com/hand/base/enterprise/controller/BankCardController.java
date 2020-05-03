package com.hand.base.enterprise.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.service.BasicService;
import com.hand.base.enterprise.model.BankCard;
import com.hand.base.enterprise.service.BankCardService;
@Controller("BankCardController")
@RequestMapping("/action/portal/bankCard")
public class BankCardController extends BasicController<BankCard>{
	
	@Resource
	private BankCardService bankCardService;
	
	@Override
	public BasicService<BankCard> getBasicService() throws Exception {
		return bankCardService;
	}
	
}
