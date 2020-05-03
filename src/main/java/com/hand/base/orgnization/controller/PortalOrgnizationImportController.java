package com.hand.base.orgnization.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.model.CallParam;
import com.hand.base.basic.service.BasicService;
import com.hand.base.orgnization.model.Orgnization;
import com.hand.base.orgnization.service.OrgImportService;
import com.hand.base.user.model.User;
import com.hand.core.util.UserUtil;

@Controller
@RequestMapping("/portal/orgImport")
public class PortalOrgnizationImportController extends BasicController<Orgnization> {
	//private static final Logger logger = LogManager.getLogger(PortalOrgnizationImportController.class);
	@Resource
	private OrgImportService orgImportService;
	
	@Override
	public BasicService<Orgnization>  getBasicService() throws Exception{
		return orgImportService;
	}
	
	@Override
	public void beforQueryAllOrExample(Orgnization entity, HttpServletRequest request) throws Exception{
		User user = UserUtil.getUser(null);
		if(entity.getConditionSql() == null){
			entity.setConditionSql("");
		}
		entity.setConditionSql(entity.getConditionSql()+" and createdBy="+"'"+user.getId()+"'");
	}
	
	@RequestMapping(value = "/check", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> check(CallParam callParam, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			orgImportService.runOrganizationCheck(callParam);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value = "/orgImpInsert", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> orgImpInsert(CallParam callParam, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			orgImportService.runNewOrganizationForimp(callParam);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}

}
