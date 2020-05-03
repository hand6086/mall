package com.hand.base.goods.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.service.BasicService;
import com.hand.base.goods.model.GoodsPrice;
import com.hand.base.goods.service.GoodsMerchantsService;

@Controller
@RequestMapping("/action/portal/goodsMerchants")
public class PortalGoodsMerchantsController extends BasicController<GoodsPrice> {
	@Autowired
	private GoodsMerchantsService goodsMerchantsService;
    
	@Override
	public BasicService<GoodsPrice> getBasicService() throws Exception {
		return goodsMerchantsService;
	}
	
}
