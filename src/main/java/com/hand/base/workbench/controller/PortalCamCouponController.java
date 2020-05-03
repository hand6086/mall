package com.hand.base.workbench.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.controller.BasicControllerException;
import com.hand.base.basic.service.BasicService;
import com.hand.base.workbench.model.CamCoupon;
import com.hand.base.workbench.model.CamPic;
import com.hand.base.workbench.service.CamCouponService;

@Controller
@RequestMapping("/action/portal/camCoupon")
public class PortalCamCouponController extends BasicController<CamCoupon> {
	@Autowired
	private CamCouponService camCouponService;
    
	@Override
	public BasicService<CamCoupon> getBasicService() throws Exception {
		return camCouponService;
	}
	
	public void beforQueryExample(CamCoupon entity, HttpServletRequest request) throws Exception{
		entity.setOauth("");
	}
}
