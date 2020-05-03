package com.hand.base.order.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.controller.BasicControllerException;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.order.model.CancelOrder;
import com.hand.base.order.service.CancelOrderService;
import com.hand.base.user.model.User;
import com.hand.core.basic.query.QueryParams;
import com.hand.core.util.StringUtils;
import com.hand.core.util.UserUtil;

@Controller
@RequestMapping("/action/portal/order/cancelOrder")
public class CancelOrderController extends BasicController<CancelOrder> {

	@Autowired
	private CancelOrderService cancelOrderService;

	@Override
	public BasicService<CancelOrder> getBasicService() throws Exception {
		return cancelOrderService;
	}
	
	/**
	 * 确认取消
	 * @return
	 */
	@RequestMapping(value = "/confirmCancel")
	@ResponseBody
	public Map<String, Object> confirmCancel(QueryParams qps, CancelOrder cancelOrder, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			if(StringUtils.isBlank(cancelOrder.getId())){
				throw new BasicServiceException("Id不能为空！");
			}
			HashMap<String, String> hm = new HashMap<String, String>();
			hm.put("P_PARA_1", cancelOrder.getCreatedBy());
			cancelOrderService.confirmCancel(hm);
			auditTrailInsert(cancelOrder, request, session, "U"); // 审计追踪新建记录
			
			cancelOrder = cancelOrderService.queryById(cancelOrder);
			result.put("newRow", cancelOrder);
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
}
