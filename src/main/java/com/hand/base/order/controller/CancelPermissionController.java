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
import com.hand.base.basic.service.BasicService;
import com.hand.base.order.model.CancelOrder;
import com.hand.base.order.model.CancelPermission;
import com.hand.base.order.service.CancelOrderService;
import com.hand.base.order.service.CancelPermissionService;
import com.hand.core.basic.query.QueryParams;

@Controller
@RequestMapping("/action/portal/order/cancelPermission")
public class CancelPermissionController extends BasicController<CancelPermission> {

	@Autowired
	private CancelPermissionService cancelPermissionService;
	
	@Autowired
	private CancelOrderService cancelOrderService;
	
	@Override
	public BasicService<CancelPermission> getBasicService() throws Exception {
		return cancelPermissionService;
	}
	
	@RequestMapping(value = "/queryByExamplePage")
	@ResponseBody
	public Map<String, Object> queryByExamplePage(QueryParams qps, CancelPermission entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			qps.preDealSecurity(request);
			CancelPermission t = (CancelPermission)BasicModel.transformClass(entity, qps);
			beforQueryAllOrExample(t,request);
			beforQueryExample(t,request);
			List<CancelPermission> list = new ArrayList<CancelPermission>();
			if(qps.getOnlyCountFlag()){
				result.put("success", true);
				int count = cancelPermissionService.querycancelPermissionCount(t);
				CancelPermission cancelPermission = new CancelPermission();
				cancelPermission.setTotal(count);
				list.add(cancelPermission);
				result.put("rows", list);
			}else{
				list = cancelPermissionService.queryByExamplePage(t);
				result.put("success", true);
				result.put("rows", list);
				this.pushCurrentDataCache(list, session.getId(), "base", false);
				result.put("total", getCount((BasicModel)t, list.size()));
			}
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<CancelPermission>());
			result.put("result", e.getMessage());
		}
		return result;
	}

	/**
	 * 第一个行结构
	 * 
	 * @return
	 */
	@RequestMapping(value = "/queryProductOrderPage", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> queryProductOrderPage(QueryParams qps, CancelPermission cancelPermission,
			HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			CancelPermission t = (CancelPermission) BasicModel.transformClass(CancelPermission.class, qps);
			t.preDealSecurity(request);
			List<CancelPermission> list = cancelPermissionService.queryProductOrderPage(t);
			result.put("success", true);
			result.put("rows", list);
			result.put("total", getCount(((CancelPermission) t), list.size()));
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<CancelPermission>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 取消订单 时插入数据
	 * @return
	 */
	@RequestMapping(value = "/insertCancelOrder")
	@ResponseBody
	public Map<String, Object> insertCancelOrder(CancelPermission cancelPermission, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			if("".equals(cancelPermission.getOrderNum()) || cancelPermission.getOrderNum() == null){
				result.put("msg", "订单编号不能为空!");
				result.put("success", false);
				return result;
			}
			List<CancelOrder> cancelOrderList =  cancelOrderService.queryByOrderNum(cancelPermission.getOrderNum());
			if(cancelOrderList != null && cancelOrderList.size() > 0){
				result.put("msg", "该记录已存在,请确保字段唯一!");
				result.put("success", false);
				return result;
			}
			cancelPermissionService.insert(cancelPermission);
			
			result.put("newRow", cancelPermission);
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("msg", e.getMessage());
		}
		return result;
	}
}
