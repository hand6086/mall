package com.hand.base.urlinfo.controller;



import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hand.base.urlinfo.model.UrlDutyLink;
import com.hand.base.urlinfo.service.UrlDutyLinkService;
import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.KeyGenerateService;

@Controller("UrlDutyLinkController")
@RequestMapping("/action/portal/urlDutyLink")
public class UrlDutyLinkController extends BasicController<UrlDutyLink>{
 
	@Resource
	private KeyGenerateService keyGenerateService;

	@Resource
	private UrlDutyLinkService urlDutyLinkService;

	@Override
	public BasicService<UrlDutyLink> getBasicService() throws Exception {
		return urlDutyLinkService;
	}	 
}
