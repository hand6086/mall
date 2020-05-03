package com.hand.base.o2oaccnt.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.service.BasicService;
import com.hand.base.o2oaccnt.model.Restaurant;
import com.hand.base.o2oaccnt.service.RestaurantService;

@Controller()
@RequestMapping("/action/portal/restaurant")
public class RestaurantController extends BasicController<Restaurant> {
	@Resource
	private RestaurantService restaurantService;

	@Override
	public BasicService<Restaurant> getBasicService() {
		return restaurantService;
	}

}
