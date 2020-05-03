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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.model.BasicModel;
import com.hand.base.basic.model.ListOfValue;
import com.hand.base.basic.service.BasicService;
import com.hand.base.order.model.ShoppingCart;
import com.hand.base.order.service.ShoppingCartService;
import com.hand.core.basic.query.QueryParams;
import com.hand.core.basic.query.Sorter;

@Controller
@RequestMapping("/action/portal/order/shoppingCart")
public class ShoppingCartController extends BasicController<ShoppingCart>{
	@Autowired
	private ShoppingCartService shoppingCartService;

	@Override
	public BasicService<ShoppingCart> getBasicService() throws Exception {
		return shoppingCartService;
	}
	
	/**
	 * picklist 消费者名称查询
	 * @return
	 */
	@RequestMapping(value = "/queryCustomerPage", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> queryCustomerPage(QueryParams qps, ShoppingCart shoppingCart, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			qps.setOauth("");
			qps.addSorter(new Sorter("orderDt", Sorter.DIR_DESC));// 按创建时间来排序
			ShoppingCart t = (ShoppingCart) BasicModel.transformClass(ShoppingCart.class, qps);
			List<ShoppingCart> list = shoppingCartService.queryCustomerPage(t);
			result.put("success", true);
			result.put("rows", list);
			result.put("total", getCount(((BasicModel) t), list.size()));
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<ShoppingCart>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * picklist 商品名称查询
	 * @return
	 */
	@RequestMapping(value = "/queryMerchantPage", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> queryMerchantPage(QueryParams qps, ShoppingCart shoppingCart, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			qps.setOauth("");
			qps.addSorter(new Sorter("orderDt", Sorter.DIR_DESC));// 按创建时间来排序
			ShoppingCart t = (ShoppingCart) BasicModel.transformClass(ShoppingCart.class, qps);
			List<ShoppingCart> list = shoppingCartService.queryMerchantPage(t);
			result.put("success", true);
			result.put("rows", list);
			result.put("total", getCount(((BasicModel) t), list.size()));
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<ShoppingCart>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 促销标识
	 * @return
	 */
	@RequestMapping(value = "/campaignType", method = RequestMethod.POST)
	@ResponseBody
	public Object orderStatusAll(QueryParams qps, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		ListOfValue listOfValue = new ListOfValue();
		List<ListOfValue> list = null;
		try {
			list = shoppingCartService.campaignType(listOfValue);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
}
