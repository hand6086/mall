package com.hand.base.params.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.controller.BasicControllerException;
import com.hand.base.basic.service.BasicService;
import com.hand.base.params.model.PlatformOrderPushRule;
import com.hand.base.params.service.PlatformOrderPushRuleService;

@Controller
@RequestMapping("/action/portal/params/platformOrderPushRule")
public class PlatformOrderPushRuleController extends BasicController<PlatformOrderPushRule> {
	@Autowired
	private PlatformOrderPushRuleService platformOrderPushRuleService;

	@Override
	public BasicService<PlatformOrderPushRule> getBasicService() throws Exception {
		if (platformOrderPushRuleService != null) {
			return platformOrderPushRuleService;
		}
		throw new BasicControllerException("获取Basic Service 失败，请确认程序代码是否正确！");
	}
	
}
