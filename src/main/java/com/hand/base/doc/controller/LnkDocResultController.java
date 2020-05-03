package com.hand.base.doc.controller;



import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.KeyGenerateService;
import com.hand.base.doc.model.LnkDocResult;
import com.hand.base.doc.service.LnkDocResultService;

@Controller("LnkDocResultController")
@RequestMapping("/action/portal/lnkDocResult")
public class LnkDocResultController extends BasicController<LnkDocResult>{
 
	@Resource
	private KeyGenerateService keyGenerateService;

	@Resource
	private LnkDocResultService lnkDocResultService;

	@Override
	public BasicService<LnkDocResult> getBasicService() throws Exception {
		return lnkDocResultService;
	}	 
}
