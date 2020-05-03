package com.hand.base.workbench.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.controller.BasicControllerException;
import com.hand.base.basic.service.BasicService;
import com.hand.base.workbench.model.FeedBack;
import com.hand.base.workbench.service.FeedBackService;

@Controller
@RequestMapping("/action/portal/feedBack")
public class PortalFeedBackController extends BasicController<FeedBack> {
	@Autowired
	private FeedBackService feedBackService;
    
	@Override
	public BasicService<FeedBack> getBasicService() throws Exception {
		return feedBackService;
	}
	
}
