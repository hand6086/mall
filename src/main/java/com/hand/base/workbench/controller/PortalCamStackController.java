package com.hand.base.workbench.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.controller.BasicControllerException;
import com.hand.base.basic.service.BasicService;
import com.hand.base.workbench.model.CamStack;
import com.hand.base.workbench.model.Campaign;
import com.hand.base.workbench.service.CamStackService;

@Controller
@RequestMapping("/action/portal/camStack")
public class PortalCamStackController extends BasicController<CamStack> {
	@Autowired
	private CamStackService camStackService;
    
	@Override
	public BasicService<CamStack> getBasicService() throws Exception {
		return camStackService;
	}
	
	public void beforQueryExample(CamStack entity, HttpServletRequest request) throws Exception{
		entity.setOauth("");
	}
	
}
