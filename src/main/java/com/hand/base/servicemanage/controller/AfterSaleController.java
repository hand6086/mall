package com.hand.base.servicemanage.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.service.BasicService;
import com.hand.base.servicemanage.model.AfterSale;
import com.hand.base.servicemanage.service.AfterSaleService;
import com.hand.core.util.AppConstants;

@Controller
@RequestMapping("/action/portal/afterSale")
public class AfterSaleController extends BasicController<AfterSale> {
	
	@Autowired
	private AfterSaleService afterSaleService;
	
	public BasicService<AfterSale> getBasicService() throws Exception{
		return afterSaleService;
	}
	
	@RequestMapping(value = "/queryByDetailId")
	@ResponseBody
	public Map<String, Object> queryByDetailId(AfterSale entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			AfterSale record = afterSaleService.queryById(entity);
			List<AfterSale> apply = afterSaleService.queryApplyPicAll(entity);
			List<AfterSale> returns = afterSaleService.queryReturnPicAll(entity);
			record.setAttr5(AppConstants.portalUserRefundUrl);
			result.put("result", record);
			result.put("apply", apply);
			result.put("returns", returns);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
}
