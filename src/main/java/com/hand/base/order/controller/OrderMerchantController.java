package com.hand.base.order.controller;

import java.util.ArrayList;
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
import com.hand.base.basic.model.BasicModel;
import com.hand.base.basic.service.BasicService;
import com.hand.base.order.model.OrderMerchant;
import com.hand.base.order.service.OrderMerchantService;
import com.hand.core.basic.query.QueryParams;

@Controller
@RequestMapping("/action/portal/order/orderMerchant")
public class OrderMerchantController extends BasicController<OrderMerchant>{
	@Autowired
	private OrderMerchantService orderMerchantService;

	@Override
	public BasicService<OrderMerchant> getBasicService() throws Exception {
		return orderMerchantService;
	}
	
	@RequestMapping(value = "/queryByExamplePage")
	@ResponseBody
	public Map<String, Object> queryByExamplePage(QueryParams qps, OrderMerchant entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			qps.preDealSecurity(request);
			OrderMerchant t = (OrderMerchant)BasicModel.transformClass(entity, qps);
			beforQueryAllOrExample(t,request);
			beforQueryExample(t,request);
			List<OrderMerchant> list = new ArrayList<OrderMerchant>();
			if(qps.getOnlyCountFlag()){
				result.put("success", true);
				int count = orderMerchantService.queryorderMerchantCount(t);
				OrderMerchant orderMerchant = new OrderMerchant();
				orderMerchant.setTotal(count);
				list.add(orderMerchant);
				result.put("rows", list);
			}else{
				list = orderMerchantService.queryByExamplePage(t);
				result.put("success", true);
				result.put("rows", list);
				this.pushCurrentDataCache(list, session.getId(), "base", false);
				result.put("total", getCount((BasicModel)t, list.size()));
			}
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<OrderMerchant>());
			result.put("result", e.getMessage());
		}
		return result;
	}
}
