package com.hand.base.aftersalemanagement.controller;



import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hand.base.aftersalemanagement.model.OrderEvaluation;
import com.hand.base.aftersalemanagement.service.OrderEvaluationService;
import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.controller.BasicControllerException;
import com.hand.base.basic.model.BasicModel;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.KeyGenerateService;
import com.hand.core.basic.query.QueryParams;

@Controller
@RequestMapping("/action/portal/orderevaluation")
public class OrderEvaluationController extends BasicController<OrderEvaluation> {
	@Autowired
	private OrderEvaluationService orderevaluationService;
	@Resource
	private KeyGenerateService keyGenerateService;
	public BasicService<OrderEvaluation> getBasicService() throws Exception{
		if(orderevaluationService != null){
			return orderevaluationService;
		}
		throw new BasicControllerException("获取Basic Service 失败，请确认程序代码是否正确！");
	}
	
	@RequestMapping(value = "/queryByExamplePage")
	@ResponseBody
	public Map<String, Object> queryByExamplePage(QueryParams qps, OrderEvaluation entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			qps.preDealSecurity(request);
			OrderEvaluation t = (OrderEvaluation)BasicModel.transformClass(entity, qps);
			beforQueryAllOrExample(t,request);
			beforQueryExample(t,request);
			List<OrderEvaluation> list = new ArrayList<OrderEvaluation>();
			if(qps.getOnlyCountFlag()){
				result.put("success", true);
				int count = orderevaluationService.queryorderevaluationCount(t);
				OrderEvaluation orderEvaluation = new OrderEvaluation();
				orderEvaluation.setTotal(count);
				list.add(orderEvaluation);
				result.put("rows", list);
			}else{
				list = orderevaluationService.queryByExamplePage(t);
				result.put("success", true);
				result.put("rows", list);
				this.pushCurrentDataCache(list, session.getId(), "base", false);
				result.put("total", getCount((BasicModel)t, list.size()));
			}
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<OrderEvaluation>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value = "/brandQueryByExamplePage")
	@ResponseBody
	public Map<String, Object> brandQueryByExamplePage(QueryParams qps, OrderEvaluation entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			qps.preDealSecurity(request);
			OrderEvaluation t = (OrderEvaluation)BasicModel.transformClass(entity, qps);
			beforQueryAllOrExample(t,request);
			beforQueryExample(t,request);
			List<OrderEvaluation> list = new ArrayList<OrderEvaluation>();
			if(qps.getOnlyCountFlag()){
				result.put("success", true);
				int count = orderevaluationService.brandQueryorderevaluationCount(t);
				OrderEvaluation orderEvaluation = new OrderEvaluation();
				orderEvaluation.setTotal(count);
				list.add(orderEvaluation);
				result.put("rows", list);
			}else{
				list = orderevaluationService.brandQueryByExamplePage(t);
				result.put("success", true);
				result.put("rows", list);
				this.pushCurrentDataCache(list, session.getId(), "base", false);
				result.put("total", getCount((BasicModel)t, list.size()));
			}
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<OrderEvaluation>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping("/queryevaluationPage")
	@ResponseBody
	public Map<String, Object> queryevaluationPage(QueryParams qps, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		try{
			qps.preDealSecurity(request);
			
			OrderEvaluation t = (OrderEvaluation)BasicModel.transformClass(OrderEvaluation.class, qps);
			beforQueryAllOrExample(t,request);
			beforQueryExample(t,request);
			
			List<OrderEvaluation> list = orderevaluationService.queryevaluationPage(t);
			result.put("success", true);
			result.put("rows", list);
			this.pushCurrentDataCache(list, session.getId(), "base", false);
			result.put("total", getCount((BasicModel)t, list.size()));
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<OrderEvaluation>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	

	
}
