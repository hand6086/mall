package com.hand.base.goods.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.service.BasicService;
import com.hand.base.goods.model.GoodsSeriesCity;
import com.hand.base.goods.service.GoodsSeriesCityService;

@Controller
@RequestMapping("/action/portal/goodsSeriesCity")
public class PortalGoodsSeriesCityController extends BasicController<GoodsSeriesCity> {
	@Autowired
	private GoodsSeriesCityService goodsSeriesCityService;
    
	@Override
	public BasicService<GoodsSeriesCity> getBasicService() throws Exception {
		return goodsSeriesCityService;
	}
	
}
