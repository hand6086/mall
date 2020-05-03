package com.hand.base.goods.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.service.BasicService;
import com.hand.base.goods.model.Goods;
import com.hand.base.goods.service.GoodsSkuService;

@Controller
@RequestMapping("/action/portal/goodsSku")
public class PortalGoodsSkuController extends BasicController<Goods> {
	@Autowired
	private GoodsSkuService goodsSkuService;
	
	@Override
	public BasicService<Goods> getBasicService() throws Exception {
		return goodsSkuService;
	}
	
}
