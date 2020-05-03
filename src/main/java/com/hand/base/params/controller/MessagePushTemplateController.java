package com.hand.base.params.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.controller.BasicControllerException;
import com.hand.base.basic.service.BasicService;
import com.hand.base.params.model.MessagePushTemplate;
import com.hand.base.params.service.MessagePushTemplateService;

@Controller
@RequestMapping("/action/portal/params/messagePushTemplate")
public class MessagePushTemplateController extends BasicController<MessagePushTemplate> {

	@Autowired
	private MessagePushTemplateService messagePushTemplateService;

	@Override
	public BasicService<MessagePushTemplate> getBasicService() throws Exception {
		if (messagePushTemplateService != null) {
			return messagePushTemplateService;
		}
		throw new BasicControllerException("获取Basic Service 失败，请确认程序代码是否正确！");
	}

}
