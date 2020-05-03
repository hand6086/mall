package com.hand.base.brandOrder.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.KeyGenerateService;
import com.hand.base.brandOrder.model.OrderItem;
import com.hand.base.brandOrder.service.OrderItemService;

@Controller("OrderItemController")
@RequestMapping("/action/portal/orderItem")
public class OrderItemController extends BasicController<OrderItem>{
 
	@Resource
	private KeyGenerateService keyGenerateService;

	@Resource
	private OrderItemService orderItemService;

	@Override
	public BasicService<OrderItem> getBasicService() throws Exception {
		return orderItemService;
	}	 
}
