package com.hand.base.brandOrder.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.hand.core.modules.export.ExportFactory;
import com.hand.core.modules.export.ExportWriter;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.model.BasicModel;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.KeyGenerateService;
import com.hand.base.brandOrder.model.Order;
import com.hand.base.brandOrder.service.OrderItemService;
import com.hand.base.brandOrder.service.OrderService;
import com.hand.core.basic.query.QueryParams;

@Controller("OrderController")
@RequestMapping("/action/portal/order")
public class OrderController extends BasicController<Order>{
 
	@Resource
	private KeyGenerateService keyGenerateService;

	@Resource
	private OrderService orderService;

	@Resource
	private OrderItemService orderItemService;
	
	@Override
	public BasicService<Order> getBasicService() throws Exception {
		return orderService;
	}	
	
	/**
	 * 根据条件查询记录,默认分页(若将'pageFlag'设置为'false'，则不分页)
	 */
	@RequestMapping(value = "/batchQueryOrderPage")
	@ResponseBody
	public Map<String, Object> batchQueryOrderPage(QueryParams qps, Order entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			qps.preDealSecurity(request);
			Order t = (Order)BasicModel.transformClass(entity, qps);
			beforQueryAllOrExample(t,request);
			beforQueryExample(t,request);
			List<Order> list = null;
			
			list = orderService.batchQueryOrderPage(t);
			
			t.setPageFlag(false);
			int totalPage = (int) Math.ceil(((double) orderService.brandQueryByExamplePage(t).size())/((double) t.getRows()));
			result.put("success", true);
			result.put("rows", list);
			result.put("totalPage", totalPage);
			if(!t.getOnlyCountFlag()){
				this.pushCurrentDataCache(list, session.getId(), "base", false);
			}
			result.put("total", getCount((BasicModel)t, list.size()));
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<Order>());
			result.put("result", e.getMessage());
		}
		return result;
	}

	/**
	 * 导出
	 */
	@RequestMapping(value = "/batchQueryOrderPage/exportData")
	@ResponseBody
	public Map<String, Object> batchQueryOrderExportData(Order entity, QueryParams qps, HttpSession session,
										  HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			qps.preDealSecurity(request);
			ExportWriter exportWriter = ExportFactory.newInstance(qps);
			Order t = (Order)BasicModel.transformClass(entity, qps);
			beforExportExample(t,request);
			beforQueryAllOrExample(t,request);
			beforQueryExample(t,request);
			//导出全部 不分页
			t.setPageFlag(false);
			List<Order> list = orderService.batchQueryOrderExportPage(t);

			while(!qps.stopExport){
				exportWriter.wirteData(list);
			}
			result.put("success", true);
			result.put("url", exportWriter.getUrlPath());
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
}
