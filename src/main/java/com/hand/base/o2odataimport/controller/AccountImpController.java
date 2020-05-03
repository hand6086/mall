package com.hand.base.o2odataimport.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.model.CallParam;
import com.hand.base.basic.service.BasicService;
import com.hand.base.o2odataimport.model.AccountTemp;
import com.hand.base.o2odataimport.service.AccountImpService;
@Controller
@RequestMapping("/action/portal/accountTemp")
public class AccountImpController extends BasicController<AccountTemp>{
	@Resource
	private AccountImpService acctImpService;
	
	public BasicService<AccountTemp> getBasicService(){
		return acctImpService;
	}
	
	@RequestMapping(value = "/check", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> check(CallParam callParam, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			acctImpService.runAccountCheck(callParam);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value = "/accntImpInsert", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> accntImpInsert(CallParam callParam, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			acctImpService.runAccountInsert(callParam);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}

}
