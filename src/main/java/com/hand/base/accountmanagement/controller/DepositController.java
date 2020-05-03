package com.hand.base.accountmanagement.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hand.base.accountmanagement.model.PayInfo;
import com.hand.base.accountmanagement.service.DepositService;
import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.KeyGenerateService;

@Controller
@RequestMapping("/action/portal/deposit")

public class DepositController extends BasicController<PayInfo> {
	@Resource
	private KeyGenerateService keyGenerateService;

	@Resource
	private DepositService depositService;

	@Override
	public BasicService<PayInfo> getBasicService() throws Exception {
		return depositService;
	}

	/**
	 * 插入押金记录
	 * 
	 * @param entity
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/insertDeposit")
	@ResponseBody
	public Map<String, Object> insertDeposit(PayInfo entity, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			beforInsert(entity, request);
			beforUpsert(entity, request);
			depositService.insertDeposit(entity);

			auditTrailInsert(entity, request, session, "N"); // 审计追踪新建记录

			PayInfo newEntry = depositService.queryById(entity);
			result.put("newRow", newEntry);
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
}
