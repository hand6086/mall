package com.hand.base.email.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hand.base.email.model.EmailInfo;
import com.hand.base.email.service.EmailService;
import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.KeyGenerateService;


@Controller
@RequestMapping("/action/portal/email")
public class PortalEmailController extends BasicController<EmailInfo>{
	
	@Resource
	private EmailService emailService;
	@Resource
	private KeyGenerateService keyGenerateService;
	@Override
	public BasicService<EmailInfo>  getBasicService() throws Exception{
		return emailService;
	}
	
}
