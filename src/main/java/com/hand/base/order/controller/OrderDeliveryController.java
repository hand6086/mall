package com.hand.base.order.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.controller.BasicControllerException;
import com.hand.base.basic.model.BasicModel;
import com.hand.base.basic.model.CallParam;
import com.hand.base.basic.service.BasicService;
import com.hand.base.common.service.MyFileService;
import com.hand.base.order.model.OrderDelivery;
import com.hand.base.order.model.PlatformOrder;
import com.hand.base.order.service.OrderDeliveryService;
import com.hand.base.order.service.PlatformOrderService;
import com.hand.core.basic.query.QueryParams;
import com.hand.core.modules.export.ExportFactory;
import com.hand.core.modules.export.ExportWriter;

@Controller
@RequestMapping("/action/portal/orderDelivery")
public class OrderDeliveryController extends BasicController<OrderDelivery>{
	private static final Logger logger = LogManager.getLogger(OrderDeliveryController.class);
	
	@Autowired
	private OrderDeliveryService orderDeliveryService;
	
	@Autowired
	private PlatformOrderService platformOrderService;
	
	@Resource
	private MyFileService myFileService;
	
	@Override
	public BasicService<OrderDelivery> getBasicService() throws Exception {
		return orderDeliveryService;
	}
	
	/**
	 * 品牌馆订单状态更新
	 */
	@RequestMapping(value = "/logisticsUpdate")
	@ResponseBody
	public Map<String, Object> logisticsUpdate(@RequestBody List<OrderDelivery> list, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			OrderDelivery entity = null;
			OrderDelivery orderDelivery = new OrderDelivery();
			String stringArray[] = new String[list.size()];
			for(int i =0;list != null && i < list.size();i++){				
				entity = list.get(i);				
				if(!entity.getCheckStatus().equals("Check Ok")){
					throw new BasicControllerException("提交数据必须校验通过！");
				}
				orderDelivery = orderDeliveryService.queryOrderId(entity);
				String attrib48 =  orderDelivery.getAttrib48();
				if(!attrib48.equals("To_Deliver")){
					entity.setErrorMessage("更新的订单状态必须为待发货状态！");
					orderDeliveryService.update(entity);
					stringArray[i]="400";
				}else{
				stringArray[i]=entity.getOrderNumber();
				}
			}
			if(stringArray.length==0){
				throw new BasicControllerException("提交的有效数据为0条！");
			}
			orderDelivery.setOrdnumArray(stringArray);
			orderDeliveryService.logisticsUpdate(orderDelivery);	

			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}

	
	@RequestMapping(value = "/check", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> check(CallParam callParam, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			orderDeliveryService.runOrderCheck(callParam);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value = "/orderUpdata", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> orderUpdata(CallParam callParam, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			orderDeliveryService.runOrderImport(callParam);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
}
