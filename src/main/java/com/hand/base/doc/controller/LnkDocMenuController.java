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
import com.hand.base.doc.model.LnkDocMenu;
import com.hand.base.doc.model.LnkDocMenuLine;
import com.hand.base.doc.service.LnkDocMenuLineService;
import com.hand.base.doc.service.LnkDocMenuService;
import com.hand.core.basic.query.QueryParams;

@Controller("LnkDocMenuController")
@RequestMapping("/action/portal/lnkDocMenu")
public class LnkDocMenuController extends BasicController<LnkDocMenu>{
	
	private static final Logger logger = LogManager.getLogger(LnkDocMenuController.class);
 
	@Resource
	private KeyGenerateService keyGenerateService;

	@Resource
	private LnkDocMenuService lnkDocMenuService;

	@Override
	public BasicService<LnkDocMenu> getBasicService() throws Exception {
		return lnkDocMenuService;
	}

	@Resource
	private LnkDocMenuLineService lnkDocMenuLineService;
	
	@RequestMapping(value = "/init", method = RequestMethod.GET)
	public String init(QueryParams qps, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			List<LnkDocMenu> list = lnkDocMenuService.queryAll(null);
			for(LnkDocMenu lnkDocMenu : list){
			/*	List<LnkDocMenuLine> menuLineList = new ArrayList<LnkDocMenuLine>();
				LnkDocMenuLine menuLine = new LnkDocMenuLine();*/
				List<LnkDocMenuLine>	menuLineList=lnkDocMenuLineService.queryMenuLine(lnkDocMenu.getId());
					lnkDocMenu.setMenuLineList(menuLineList);

			}
			session.setAttribute("lnkDocMenuList", list);
		}  catch (Exception e) {
			result.put("success", false);
			logger.error("--------------", e);
		}
		return "redirect:/doc/docIndex.jsp";
	}
}
