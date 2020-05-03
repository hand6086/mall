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

import com.hand.base.aftersalemanagement.model.WithRefundOrder;
import com.hand.base.aftersalemanagement.service.WithRefundOrderService;
import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.controller.BasicControllerException;
import com.hand.base.basic.model.BasicModel;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.KeyGenerateService;
import com.hand.core.basic.query.QueryParams;

@Controller
@RequestMapping("/action/portal/withrefundorder")
public class WithRefundOrderController extends BasicController<WithRefundOrder> {
	@Autowired
	private WithRefundOrderService withrefundorderService;
	@Resource
	private KeyGenerateService keyGenerateService;
	public BasicService<WithRefundOrder> getBasicService() throws Exception{
		if(withrefundorderService != null){
			return withrefundorderService;
		}
		throw new BasicControllerException("获取Basic Service 失败，请确认程序代码是否正确！");
	}
	
	
	
	@RequestMapping("/queryoOderGoodsPage")
	@ResponseBody
	public Map<String, Object> queryoOderGoods(QueryParams qps, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			qps.preDealSecurity(request);
			
			WithRefundOrder t = (WithRefundOrder)BasicModel.transformClass(WithRefundOrder.class, qps);
			beforQueryAllOrExample(t,request);
			beforQueryExample(t,request);
			List<WithRefundOrder> list = withrefundorderService.queryoOderGoodsPage(t);
			result.put("success", true);
			result.put("rows", list);
			this.pushCurrentDataCache(list, session.getId(), "base", false);
			result.put("total", getCount((BasicModel)t, list.size()));
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<WithRefundOrder>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping("/brandQueryoOderGoodsPage")
	@ResponseBody
	public Map<String, Object> brandQueryoOderGoodsPage(QueryParams qps, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			qps.preDealSecurity(request);
			
			WithRefundOrder t = (WithRefundOrder)BasicModel.transformClass(WithRefundOrder.class, qps);
			beforQueryAllOrExample(t,request);
			beforQueryExample(t,request);
			List<WithRefundOrder> list = withrefundorderService.brandQueryoOderGoodsPage(t);
			result.put("success", true);
			result.put("rows", list);
			this.pushCurrentDataCache(list, session.getId(), "base", false);
			result.put("total", getCount((BasicModel)t, list.size()));
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<WithRefundOrder>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value = "/queryType")
	@ResponseBody
	public List<WithRefundOrder> queryType(QueryParams qps,WithRefundOrder entity, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		List<WithRefundOrder> list = null;
		try{
			list = withrefundorderService.queryType(entity);
		}catch(Exception e){
			e.printStackTrace();
		}
		return list;
	}

	
}
