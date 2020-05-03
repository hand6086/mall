package com.hand.base.doc.controller;



import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.KeyGenerateService;
import com.hand.base.doc.model.LnkDocParam;
import com.hand.base.doc.service.LnkDocParamService;

@Controller("LnkDocParamController")
@RequestMapping("/action/portal/lnkDocParam")
public class LnkDocParamController extends BasicController<LnkDocParam>{
 
	@Resource
	private KeyGenerateService keyGenerateService;

	@Resource
	private LnkDocParamService lnkDocParamService;

	@Override
	public BasicService<LnkDocParam> getBasicService() throws Exception {
		return lnkDocParamService;
	}	 
}
