package com.hand.core.autoconfig.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.KeyGenerateService;
import com.hand.core.autoconfig.model.LnkInnerLink;
import com.hand.core.autoconfig.service.LnkInnerLinkService;
import com.hand.core.util.StringUtils;

@Controller
@RequestMapping("/portal/LnkInnerLink")
public class LnkInnerLinkController extends BasicController<LnkInnerLink> {
	@Resource
	private KeyGenerateService	keyGenerateService;
	@Resource
	private LnkInnerLinkService	lnkInnerLinkService;
	
	@Override
	public BasicService<LnkInnerLink> getBasicService() throws Exception {
		return lnkInnerLinkService;
	}
	
	@Override
	public void beforQueryAllOrExample(LnkInnerLink entity, HttpServletRequest request) throws Exception {
		super.beforQueryAllOrExample(entity, request);
		if(StringUtils.isBlank(entity.getParentid())){
			entity.setParentid("noMatchId");
		}
	}
}
