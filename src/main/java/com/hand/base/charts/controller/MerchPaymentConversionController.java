package com.hand.base.charts.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.service.BasicService;
import com.hand.base.charts.model.MerchPaymentConversion;
import com.hand.base.charts.service.MerchPaymentConversionService;

@Controller
@RequestMapping("/action/portal/merchPaymentConversion")
public class MerchPaymentConversionController extends BasicController<MerchPaymentConversion> {

	@Resource
	private MerchPaymentConversionService merchPaymentConversionService;

	@Override
	public BasicService<MerchPaymentConversion> getBasicService() throws Exception {
		return merchPaymentConversionService;
	}	 
}
