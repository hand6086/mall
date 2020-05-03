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
import com.hand.base.order.model.OrderSingleProduct;
import com.hand.base.order.service.OrderSingleProductService;
import com.hand.core.basic.query.QueryParams;

@Controller
@RequestMapping("/action/portal/order/orderSingleProduct")
public class OrderSingleProductController extends BasicController<OrderSingleProduct>{
	@Autowired
	private OrderSingleProductService orderSingleProductService;

	@Override
	public BasicService<OrderSingleProduct> getBasicService() throws Exception {
		return orderSingleProductService;
	}
	
	@RequestMapping(value = "/queryByExamplePage")
	@ResponseBody
	public Map<String, Object> queryByExamplePage(QueryParams qps, OrderSingleProduct entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			qps.preDealSecurity(request);
			OrderSingleProduct t = (OrderSingleProduct)BasicModel.transformClass(entity, qps);
			beforQueryAllOrExample(t,request);
			beforQueryExample(t,request);
			List<OrderSingleProduct> list = new ArrayList<OrderSingleProduct>();
			if(qps.getOnlyCountFlag()){
				result.put("success", true);
				int count = orderSingleProductService.queryorderSingleProductCount(t);
				OrderSingleProduct orderSingleProduct = new OrderSingleProduct();
				orderSingleProduct.setTotal(count);
				list.add(orderSingleProduct);
				result.put("rows", list);
			}else{
				list = orderSingleProductService.queryByExamplePage(t);
				result.put("success", true);
				result.put("rows", list);
				this.pushCurrentDataCache(list, session.getId(), "base", false);
				result.put("total", getCount((BasicModel)t, list.size()));
			}
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<OrderSingleProduct>());
			result.put("result", e.getMessage());
		}
		return result;
	}
}
