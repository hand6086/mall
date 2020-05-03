package com.hand.base.accountmanagement.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hand.base.accountmanagement.model.PayInfo;
import com.hand.base.accountmanagement.service.AvailableCashService;
import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.model.BasicModel;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.KeyGenerateService;
import com.hand.base.user.model.User;
import com.hand.core.basic.query.QueryParams;
import com.hand.core.util.StringUtils;
import com.hand.core.util.UserUtil;

@Controller
@RequestMapping("/action/portal/availablecash")

public class AvailableCashController extends BasicController<PayInfo> {
	@Resource
	private KeyGenerateService keyGenerateService;

	@Resource
	private AvailableCashService availableCashService;

	@Override
	public BasicService<PayInfo> getBasicService() throws Exception {
		return availableCashService;
	}

	/**
	 * 更新支付信息中资金状态
	 * 
	 * @param entity
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/fundStatusUpdate")
	@ResponseBody
	public Map<String, Object> fundStatusUpdate(PayInfo entity, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			availableCashService.fundStatusUpdate(entity);
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	@RequestMapping(value = "/queryByBillId")
	@ResponseBody
	public Map<String, Object> queryByBillId(PayInfo entity,QueryParams qps, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			PayInfo t = (PayInfo) BasicModel.transformClass(entity, qps);
			User user = UserUtil.getUser(session);
			List<PayInfo> list = new ArrayList<PayInfo>();
			if(StringUtils.equals(user.getUsercorpid(), "101")){
				list = availableCashService.queryByBillId(t);
			}else{
				list = availableCashService.brandQueryByBillId(t);
			}
			
			result.put("rows", list);
			result.put("success", true);
			result.put("total", getCount((BasicModel)t, list.size()));
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
}
