package com.hand.base.doc.controller;



import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.KeyGenerateService;
import com.hand.base.doc.model.LnkDocMenuLine;
import com.hand.base.doc.model.LnkDocParam;
import com.hand.base.doc.model.LnkDocResult;
import com.hand.base.doc.service.LnkDocMenuLineService;
import com.hand.base.doc.service.LnkDocParamService;
import com.hand.base.doc.service.LnkDocResultService;
import com.hand.core.basic.query.QueryParams;

@Controller("LnkDocMenuLineController")
@RequestMapping("/action/portal/lnkDocMenuLine")
public class LnkDocMenuLineController extends BasicController<LnkDocMenuLine>{
	
	private static final Logger logger = LogManager.getLogger(LnkDocMenuLineController.class);
 
	@Resource
	private KeyGenerateService keyGenerateService;
	
	@Resource
	private LnkDocParamService lnkDocParamService;
	
	@Resource
	private LnkDocResultService lnkDocResultService;
	

	@Resource
	private LnkDocMenuLineService lnkDocMenuLineService;

	@Override
	public BasicService<LnkDocMenuLine> getBasicService() throws Exception {
		return lnkDocMenuLineService;
	}	 
	
	@RequestMapping(value = "/init", method = RequestMethod.GET)
	public String init(LnkDocMenuLine entity, QueryParams qps, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			LnkDocMenuLine lnkDocMenuLine = lnkDocMenuLineService.queryById(entity);
			LnkDocParam lnkDocParam = new LnkDocParam();
			lnkDocParam.setMenuLineId(entity.getId());
			List<LnkDocParam> lnkDocParamList = lnkDocParamService.queryAll(lnkDocParam);
			
			LnkDocResult lnkDocResult = new LnkDocResult();
			lnkDocResult.setMenuLineId(entity.getId());
			List<LnkDocResult>  lnkDocResultList = lnkDocResultService.queryAll(lnkDocResult);
			
			session.setAttribute("lnkDocMenuLine", lnkDocMenuLine);
			session.setAttribute("lnkDocParamList", lnkDocParamList);
			session.setAttribute("lnkDocResultList", lnkDocResultList);
		}  catch (Exception e) {
			result.put("success", false);
			logger.error("--------------", e);
		}
		return "redirect:/doc/docInfo.jsp";
	}
}
