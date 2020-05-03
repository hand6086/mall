package com.hand.base.coupon.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.service.BasicService;
import com.hand.base.coupon.model.Goodsinformation;
import com.hand.base.coupon.service.GoodsinformationService;

@Controller
@RequestMapping("/action/portal/goodsinformation")
public class GoodsinformationController extends BasicController<Goodsinformation> {
	@Autowired
	private GoodsinformationService goodsinformationService;

	public BasicService<Goodsinformation> getBasicService() throws Exception {
		return goodsinformationService;
	}

}
