package com.hand.base.params.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.controller.BasicControllerException;
import com.hand.base.basic.service.BasicService;
import com.hand.base.params.model.AddressLabel;
import com.hand.base.params.service.AddressLabelService;

@Controller
@RequestMapping("/action/portal/params/addressLabel")
public class AddressLabelController  extends BasicController<AddressLabel>{

	@Autowired
	private AddressLabelService addressLabelService;

	@Override
	public BasicService<AddressLabel> getBasicService() throws Exception {
		if (addressLabelService != null) {
			return addressLabelService;
		}
		throw new BasicControllerException("获取Basic Service 失败，请确认程序代码是否正确！");
	}
	
}
