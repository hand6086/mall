package com.hand.base.goods.controller;

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
import com.hand.base.goods.model.GoodsSuit;
import com.hand.base.goods.service.GoodsSuitService;
import com.hand.core.basic.query.QueryParams;

@Controller
@RequestMapping("/action/portal/goodsSuit")
public class PortalGoodsSuitController extends BasicController<GoodsSuit> {
	@Autowired
	private GoodsSuitService goodsSuitService;
    
	@Override
	public BasicService<GoodsSuit> getBasicService() throws Exception {
		return goodsSuitService;
	}
	
	@RequestMapping(value = "/queryOrderPkAll")
	@ResponseBody
	public List<GoodsSuit> queryOrderPkAll(QueryParams qps,GoodsSuit entity, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		List<GoodsSuit> list = null;
		try{
			list = goodsSuitService.queryOrderPkAll(entity);
		}catch(Exception e){
			e.printStackTrace();
		}
		return list;
	}
	
	@RequestMapping(value = "/queryCustomerPkAll")
	@ResponseBody
	public List<GoodsSuit> queryCustomerPkAll(QueryParams qps,GoodsSuit entity, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		List<GoodsSuit> list = null;
		try{
			list = goodsSuitService.queryCustomerPkAll(entity);
		}catch(Exception e){
			e.printStackTrace();
		}
		return list;
	}
	
	//改为不是套装 flag为N
	@RequestMapping(value = "/saveAsGoods")
	@ResponseBody
	public Map<String, Object> saveAsGoods(QueryParams qps, GoodsSuit entity, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			goodsSuitService.saveAsGoods(entity);
			auditTrailInsert(entity, request, session, "U"); // 审计追踪新建记录

			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
}
