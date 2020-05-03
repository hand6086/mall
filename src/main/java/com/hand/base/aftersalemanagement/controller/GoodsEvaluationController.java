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

import com.hand.base.aftersalemanagement.model.GoodsEvaluation;
import com.hand.base.aftersalemanagement.service.GoodsEvaluationService;
import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.controller.BasicControllerException;
import com.hand.base.basic.model.BasicModel;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.KeyGenerateService;
import com.hand.core.basic.query.QueryParams;

@Controller
@RequestMapping("/action/portal/goodsevaluation")
public class GoodsEvaluationController extends BasicController<GoodsEvaluation> {
	@Autowired
	private GoodsEvaluationService goodsevaluationService;
	@Resource
	private KeyGenerateService keyGenerateService;
	public BasicService<GoodsEvaluation> getBasicService() throws Exception{
		if(goodsevaluationService != null){
			return goodsevaluationService;
		}
		throw new BasicControllerException("获取Basic Service 失败，请确认程序代码是否正确！");
	}
	
	@RequestMapping(value = "/queryByExamplePage")
	@ResponseBody
	public Map<String, Object> queryByExamplePage(QueryParams qps, GoodsEvaluation entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			qps.preDealSecurity(request);
			GoodsEvaluation t = (GoodsEvaluation)BasicModel.transformClass(entity, qps);
			beforQueryAllOrExample(t,request);
			beforQueryExample(t,request);
			List<GoodsEvaluation> list = new ArrayList<GoodsEvaluation>();
			if(qps.getOnlyCountFlag()){
				result.put("success", true);
				int count = goodsevaluationService.querygoodsevaluationCount(t);
				GoodsEvaluation goodsEvaluation = new GoodsEvaluation();
				goodsEvaluation.setTotal(count);
				list.add(goodsEvaluation);
				result.put("rows", list);
			}else{
				list = goodsevaluationService.queryByExamplePage(t);
				result.put("success", true);
				result.put("rows", list);
				this.pushCurrentDataCache(list, session.getId(), "base", false);
				result.put("total", getCount((BasicModel)t, list.size()));
			}
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<GoodsEvaluation>());
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
			
			GoodsEvaluation t = (GoodsEvaluation)BasicModel.transformClass(GoodsEvaluation.class, qps);
			beforQueryAllOrExample(t,request);
			beforQueryExample(t,request);
			List<GoodsEvaluation> list = goodsevaluationService.queryevaluationPage(t);
			result.put("success", true);
			result.put("rows", list);
			this.pushCurrentDataCache(list, session.getId(), "base", false);
			result.put("total", getCount((BasicModel)t, list.size()));
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<GoodsEvaluation>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	

	
}
