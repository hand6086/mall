package com.hand.base.params.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.controller.BasicControllerException;
import com.hand.base.basic.model.BasicModel;
import com.hand.base.basic.service.BasicService;
import com.hand.base.charge.model.ChargeVerification;
import com.hand.base.charge.model.PayInfo;
import com.hand.base.params.model.ClientUpdate;
import com.hand.base.params.service.ClientUpdateService;
import com.hand.core.basic.query.QueryParams;
import com.hand.core.basic.query.Sorter;

@Controller
@RequestMapping("/action/portal/params/clientUpdate")
public class ClientUpdateController extends BasicController<ClientUpdate> {

	@Autowired
	private ClientUpdateService clientUpdateService;

	@Override
	public BasicService<ClientUpdate> getBasicService() throws Exception {
		if (clientUpdateService != null) {
			return clientUpdateService;
		}
		throw new BasicControllerException("获取Basic Service 失败，请确认程序代码是否正确！");
	}

}
