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
import com.hand.base.charge.model.Settlement;
import com.hand.base.charge.service.SettlementService;
import com.hand.base.user.model.User;
import com.hand.core.basic.query.QueryParams;
import com.hand.core.basic.query.Sorter;
import com.hand.core.util.StringUtils;
import com.hand.core.util.UserUtil;

@Controller
@RequestMapping("/action/portal/charge/settlement")
public class SettlementController extends BasicController<Settlement> {
	@Autowired
	private SettlementService settlementService;
	
	@Autowired
	protected KeyGenerateService keyGenerateService;
	
	@Override
	public BasicService<Settlement> getBasicService() throws Exception {
		if (settlementService != null) {
			return settlementService;
		}
		throw new BasicControllerException("获取Basic Service 失败，请确认程序代码是否正确！");
	}

	/**
	 * 城市的pickList
	 * 
	 * @param qps
	 * @param settlement
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/queryCityPage", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> queryCityPage(QueryParams qps, Settlement settlement, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			qps.addSorter(new Sorter("orderDt", Sorter.DIR_DESC));// 按创建时间来排序
			Settlement t = (Settlement) BasicModel.transformClass(Settlement.class, qps);
			t.preDealSecurity(request);
			List<Settlement> list = settlementService.queryCityPage(t);
			result.put("success", true);
			result.put("rows", list);
			result.put("total", getCount(((BasicModel) t), list.size()));
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<Settlement>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 头结构的新增记录
	 * @return
	 */
	@RequestMapping(value = "/insertCity")
	@ResponseBody
	public Map<String, Object> insertCity(Settlement settlement, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			User user = UserUtil.getUser(null);
			settlement.setCreatedBy(user.getCreatedBy());
			settlement.setCorpid(user.getCorpid());
			if(StringUtils.isBlank(settlement.getId())){
				settlement.setId(keyGenerateService.keyGenerate());
			}
			settlementService.insertCity(settlement);
			auditTrailInsert(settlement, request, session, "N"); // 审计追踪新建记录
			
			settlement = settlementService.queryById(settlement);
			result.put("newRow", settlement);
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	/**
	 * 第一个行结构的新增记录
	 * @return
	 */
	@RequestMapping(value = "/add")
	@ResponseBody
	public Map<String, Object> add(Settlement settlement, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			User user = UserUtil.getUser(null);
			settlement.setCreatedBy(user.getCreatedBy());
			settlement.setCorpid(user.getCorpid());
			if(StringUtils.isBlank(settlement.getId())){
				settlement.setId(keyGenerateService.keyGenerate());
			}
			settlementService.add(settlement);
			auditTrailInsert(settlement, request, session, "US"); // 审计追踪新建记录
			
			settlement = settlementService.queryDetailById(settlement);
			result.put("newRow", settlement);
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
	public Map<String, Object> deleteDetailById(Settlement settlement, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			if(StringUtils.isBlank(settlement.getId())){
				throw new BasicServiceException("Id不能为空！");
			}
			settlementService.deleteDetailById(settlement);
			auditTrailInsert(settlement,request,session,"D"); // 审计追踪新建记录
			
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 第一个行结构的更新操作
	 * @return
	 */
	@RequestMapping(value = "/updateDetail")
	@ResponseBody
	public Map<String, Object> updateDetail(Settlement settlement, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			if(StringUtils.isBlank(settlement.getId())){
				throw new BasicServiceException("Id不能为空！");
			}
			settlementService.updateDetail(settlement);
			auditTrailInsert(settlement, request, session, "US"); // 审计追踪新建记录
			
			settlement = settlementService.queryDetailById(settlement);
			result.put("newRow", settlement);
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}

	/**
	 * 第一个行结构
	 * 
	 * @param qps
	 * @param settlement
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/queryDetailPage", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> queryDetailPage(QueryParams qps, Settlement settlement, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			Settlement t = (Settlement) BasicModel.transformClass(Settlement.class, qps);
			t.preDealSecurity(request);
			List<Settlement> list = settlementService.queryDetailPage(t);
			result.put("success", true);
			result.put("rows", list);
			result.put("total", getCount(((BasicModel) t), list.size()));
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<Settlement>());
			result.put("result", e.getMessage());
		}
		return result;
	}

	/**
	 * 代收货款结算 第二个行结构
	 * 
	 * @param qps
	 * @param settlement
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/querySettlementDetailPage", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> querySettlementDetailPage(QueryParams qps, Settlement settlement, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			Settlement t = (Settlement) BasicModel.transformClass(Settlement.class, qps);
			t.preDealSecurity(request);
			List<Settlement> list = settlementService.querySettlementDetailPage(t);
			result.put("success", true);
			result.put("rows", list);
			result.put("total", getCount(((BasicModel) t), list.size()));
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<Settlement>());
			result.put("result", e.getMessage());
		}
		return result;
	}

	/**
	 * 第三个行结构
	 * 
	 * @param qps
	 * @param settlement
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/querySettlementSubDetailPage", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> querySettlementSubDetailPage(QueryParams qps, Settlement settlement, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			Settlement t = (Settlement) BasicModel.transformClass(Settlement.class, qps);
			t.preDealSecurity(request);
			List<Settlement> list = settlementService.querySettlementSubDetailPage(t);
			result.put("success", true);
			result.put("rows", list);
			result.put("total", getCount(((BasicModel) t), list.size()));
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<Settlement>());
			result.put("result", e.getMessage());
		}
		return result;
	}

	/**
	 * 第二个行结构的更新结算状态
	 * @return
	 */
	@RequestMapping(value = "/updateSubDetail")
	@ResponseBody
	public Map<String, Object> updateSubDetail(Settlement settlement, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			settlementService.updateSubDetail(settlement);
			auditTrailInsert(settlement, request, session, "U"); // 审计追踪新建记录
			settlement = settlementService.querySubDetailById(settlement);
			result.put("newRow", settlement);
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}

}
