package com.hand.core.autoconfig.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.KeyGenerateService;
import com.hand.core.autoconfig.model.LnkInnerWhere;
import com.hand.core.autoconfig.service.LnkInnerWhereService;
import com.hand.core.util.StringUtils;

@Controller
@RequestMapping("/portal/LnkInnerWhere")
public class LnkInnerWhereController extends BasicController<LnkInnerWhere> {
	@Resource
	private KeyGenerateService		keyGenerateService;
	@Resource
	private LnkInnerWhereService	lnkInnerWhereService;
	
	@Override
	public BasicService<LnkInnerWhere> getBasicService() throws Exception {
		return lnkInnerWhereService;
	}
	
	@Override
	public void beforQueryAllOrExample(LnkInnerWhere entity, HttpServletRequest request) throws Exception {
		super.beforQueryAllOrExample(entity, request);
		if(StringUtils.isBlank(entity.getParentid())){
			entity.setParentid("noMatchId");
		}
	}
}
