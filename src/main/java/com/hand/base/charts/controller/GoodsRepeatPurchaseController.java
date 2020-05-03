package com.hand.base.charts.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.service.BasicService;
import com.hand.base.charts.model.GoodsRepeatPurchase;
import com.hand.base.charts.service.GoodsRepeatPurchaseService;

@Controller
@RequestMapping("/action/portal/goodsRepeatPurchase")
public class GoodsRepeatPurchaseController extends BasicController<GoodsRepeatPurchase> {

	@Resource
	private GoodsRepeatPurchaseService goodsRepeatPurchaseService;

	@Override
	public BasicService<GoodsRepeatPurchase> getBasicService() throws Exception {
		return goodsRepeatPurchaseService;
	}	 
}
