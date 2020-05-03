package com.hand.base.promotion.controller;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.service.BasicService;
import com.hand.base.o2oaccnt.service.AreaManagerService;
import com.hand.base.promotion.model.PromotionProduct;
import com.hand.base.promotion.service.PromotionProductService;

/**
 * 名品促销商品列表
 * 
 * @author guo
 *
 */
@Controller
@RequestMapping("/action/portal/promotionProduct")
public class PromotionProductController extends BasicController<PromotionProduct> {
	@Autowired
	private PromotionProductService promotionProductService;

	public BasicService<PromotionProduct> getBasicService() throws Exception {
		return promotionProductService;
	}
	@Resource
	private AreaManagerService areaManagerService;
}
