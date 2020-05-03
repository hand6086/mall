package com.hand.base.charge.controller;

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
import com.hand.base.basic.controller.BasicControllerException;
import com.hand.base.basic.model.BasicModel;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.basic.service.KeyGenerateService;
import com.hand.base.charge.model.ChargeVerification;
import com.hand.base.charge.model.PayInfo;
import com.hand.base.charge.model.Settlement;
import com.hand.base.charge.service.ChargeVerificationService;
import com.hand.base.user.model.User;
import com.hand.core.basic.query.QueryParams;
import com.hand.core.basic.query.Sorter;
import com.hand.core.util.StringUtils;
import com.hand.core.util.UserUtil;

@Controller
@RequestMapping("/action/portal/charge/chargeVerification")
public class ChargeVerificationController extends BasicController<ChargeVerification>{

	@Autowired
	private ChargeVerificationService chargeVerificationService;
	
	@Autowired
	protected KeyGenerateService keyGenerateService;
	
	@Override
	public BasicService<ChargeVerification> getBasicService() throws Exception {
		if (chargeVerificationService != null) {
			return chargeVerificationService;
		}
		throw new BasicControllerException("获取Basic Service 失败，请确认程序代码是否正确！");
	}
	
	/**
	 * 查询费用核销日期 (第一个行结构)
	 * @param qps
	 * @param chargeVerification
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/queryChargeDatePage", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> queryChargeDatePage(QueryParams qps, ChargeVerification chargeVerification, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			qps.addSorter(new Sorter("orderDt", Sorter.DIR_DESC));// 按创建时间来排序
			ChargeVerification t = (ChargeVerification) BasicModel.transformClass(ChargeVerification.class, qps);
			t.preDealSecurity(request);
			List<ChargeVerification> list = chargeVerificationService.queryChargeDatePage(t);
			result.put("success", true);
			result.put("rows", list);
			result.put("total", getCount(((BasicModel) t), list.size()));
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<ChargeVerification>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 查询费用信息 (第二个行结构)
	 * @return
	 */
	@RequestMapping(value = "/queryChargeDetailPage", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> queryChargeDetailPage(QueryParams qps, ChargeVerification chargeVerification, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			ChargeVerification t = (ChargeVerification) BasicModel.transformClass(ChargeVerification.class, qps);
			t.preDealSecurity(request);
			List<ChargeVerification> list = chargeVerificationService.queryChargeDetailPage(t);
			result.put("success", true);
			result.put("rows", list);
			result.put("total", getCount(((ChargeVerification) t), list.size()));
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<ChargeVerification>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 查询费用订单信息 (第三个行结构)
	 * @param qps
	 * @param chargeVerification
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/queryChargeOrderDetailPage", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> queryChargeOrderDetailPage(QueryParams qps, ChargeVerification chargeVerification, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			ChargeVerification t = (ChargeVerification) BasicModel.transformClass(ChargeVerification.class, qps);
			t.preDealSecurity(request);
			List<ChargeVerification> list = chargeVerificationService.queryChargeOrderDetailPage(t);
			result.put("success", true);
			result.put("rows", list);
			result.put("total", getCount(((BasicModel) t), list.size()));
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<ChargeVerification>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 第一个行结构的新增记录
	 * @return
	 */
	@RequestMapping(value = "/insertDetail")
	@ResponseBody
	public Map<String, Object> insertDetail(ChargeVerification chargeVerification, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			User user = UserUtil.getUser(null);
			chargeVerification.setCreatedBy(user.getCreatedBy());
			chargeVerification.setCorpid(user.getCorpid());
			if(StringUtils.isBlank(chargeVerification.getId())){
				chargeVerification.setId(keyGenerateService.keyGenerate());
			}
			chargeVerificationService.insertDetail(chargeVerification);
			auditTrailInsert(chargeVerification, request, session, "N"); // 审计追踪新建记录
			
			chargeVerification = chargeVerificationService.queryDetailById(chargeVerification);
			result.put("newRow", chargeVerification);
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 第一个行结构的更新记录
	 * @return
	 */
	@RequestMapping(value = "/updateDetail")
	@ResponseBody
	public Map<String, Object> updateDetail(ChargeVerification chargeVerification, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			if(StringUtils.isBlank(chargeVerification.getId())){
				throw new BasicServiceException("Id不能为空！");
			}
			User user = UserUtil.getUser(null);
			chargeVerification.setCreatedBy(user.getCreatedBy());
			
			chargeVerificationService.updateDetail(chargeVerification);
			auditTrailInsert(chargeVerification, request, session, "U"); // 审计追踪新建记录
			
			chargeVerification = chargeVerificationService.queryDetailById(chargeVerification);
			result.put("newRow", chargeVerification);
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 第一个行结构的删除记录
	 * @return
	 */
	@RequestMapping(value = "/deleteDetailById")
	@ResponseBody
	public Map<String, Object> deleteDetailById(ChargeVerification chargeVerification, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			if(StringUtils.isBlank(chargeVerification.getId())){
				throw new BasicServiceException("Id不能为空！");
			}
			chargeVerificationService.deleteDetailById(chargeVerification);
			auditTrailInsert(chargeVerification, request, session, "D"); // 审计追踪新建记录
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
}
