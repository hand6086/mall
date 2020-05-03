package com.hand.base.brandpromotion.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.KeyGenerateService;
import com.hand.base.brandpromotion.model.BrandPromotionGoods;
import com.hand.base.brandpromotion.service.BrandPromotionGoodsService;

@Controller
@RequestMapping("/action/portal/brandPromotionGoods")
public class BrandPromotionGoodsController extends BasicController<BrandPromotionGoods> {

	@Resource
	private KeyGenerateService keyGenerateService;

	@Resource
	private BrandPromotionGoodsService brandPromotionGoodsService;

	@Override
	public BasicService<BrandPromotionGoods> getBasicService() throws Exception {
		return brandPromotionGoodsService;
	}
	
}
