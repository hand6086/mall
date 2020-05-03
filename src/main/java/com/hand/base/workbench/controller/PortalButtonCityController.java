package com.hand.base.workbench.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.controller.BasicControllerException;
import com.hand.base.basic.service.BasicService;
import com.hand.base.workbench.model.Button;
import com.hand.base.workbench.service.ButtonCityService;

@Controller
@RequestMapping("/action/portal/buttonCity")
public class PortalButtonCityController extends BasicController<Button> {
	@Autowired
	private ButtonCityService buttonCityService;

	@Override
	public BasicService<Button> getBasicService() throws Exception {
		return buttonCityService;
	}
	
}
