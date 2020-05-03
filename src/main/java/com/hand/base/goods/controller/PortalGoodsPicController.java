package com.hand.base.goods.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.service.BasicService;
import com.hand.base.goods.model.GoodsSuit;
import com.hand.base.goods.service.GoodsPicService;

@Controller
@RequestMapping("/action/portal/goodsPic")
public class PortalGoodsPicController extends BasicController<GoodsSuit> {
	@Autowired
	private GoodsPicService goodsPicService;
    
	@Override
	public BasicService<GoodsSuit> getBasicService() throws Exception {
		return goodsPicService;
	}
}
