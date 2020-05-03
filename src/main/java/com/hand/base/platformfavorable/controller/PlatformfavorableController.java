package com.hand.base.platformfavorable.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.controller.BasicControllerException;
import com.hand.base.basic.model.BasicModel;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.KeyGenerateService;
import com.hand.base.platformfavorable.model.Platformfavorable;
import com.hand.base.platformfavorable.service.PlatformfavorableService;
import com.hand.base.user.model.User;
import com.hand.core.basic.query.QueryParams;
import com.hand.core.util.UserUtil;

@Controller
@RequestMapping("/action/portal/platformfavorable")
public class PlatformfavorableController extends BasicController<Platformfavorable> {

	@Autowired
	private PlatformfavorableService platformfavorableService;

	@Resource
	private KeyGenerateService keyGenerateService;

	public BasicService<Platformfavorable> getBasicService() throws Exception {
		return platformfavorableService;
	}

	@RequestMapping("/queryActivityPage")
	@ResponseBody
	public Map<String, Object> queryActivity(QueryParams qps, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			qps.preDealSecurity(request);

			Platformfavorable t = (Platformfavorable) BasicModel.transformClass(Platformfavorable.class, qps);
			beforQueryAllOrExample(t, request);
			beforQueryExample(t, request);
			List<Platformfavorable> list = platformfavorableService.queryActivityPage(t);
			result.put("success", true);
			result.put("rows", list);
			this.pushCurrentDataCache(list, session.getId(), "base", false);
			result.put("total", getCount((BasicModel) t, list.size()));
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<Platformfavorable>());
			result.put("result", e.getMessage());
		}
		return result;
	}

	@RequestMapping("/queryFullOfGiftsPicklistPage")
	@ResponseBody
	public Map<String, Object> queryFullOfGiftsPicklistPage(QueryParams qps, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			if("camp".equals(qps.getAttr1())){
				qps.setOauth("");
			}
			qps.preDealSecurity(request);
			Platformfavorable t = (Platformfavorable) BasicModel.transformClass(Platformfavorable.class, qps);
			beforQueryAllOrExample(t, request);
			beforQueryExample(t, request);
			List<Platformfavorable> list = platformfavorableService.queryFullOfGiftsPicklistPage(t);
			result.put("success", true);
			result.put("rows", list);
			this.pushCurrentDataCache(list, session.getId(), "base", false);
			result.put("total", getCount((BasicModel) t, list.size()));
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<Platformfavorable>());
			result.put("result", e.getMessage());
		}
		return result;
	}

	@RequestMapping("/brandQueryCouponpicklistPage")
	@ResponseBody
	public Map<String, Object> brandQueryCouponpicklistPage(QueryParams qps, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			qps.preDealSecurity(request);
			Platformfavorable t = (Platformfavorable) BasicModel.transformClass(Platformfavorable.class, qps);
			beforQueryAllOrExample(t, request);
			beforQueryExample(t, request);
			List<Platformfavorable> list = platformfavorableService.brandQueryCouponpicklistPage(t);
			result.put("success", true);
			result.put("rows", list);
			this.pushCurrentDataCache(list, session.getId(), "base", false);
			result.put("total", getCount((BasicModel) t, list.size()));
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<Platformfavorable>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	@RequestMapping("/querycouponpicklistPage")
	@ResponseBody
	public Map<String, Object> queryCouponpicklist(QueryParams qps, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			qps.preDealSecurity(request);
			Platformfavorable t = (Platformfavorable) BasicModel.transformClass(Platformfavorable.class, qps);
			beforQueryAllOrExample(t, request);
			beforQueryExample(t, request);
			List<Platformfavorable> list = platformfavorableService.queryCouponpicklistPage(t);
			result.put("success", true);
			result.put("rows", list);
			this.pushCurrentDataCache(list, session.getId(), "base", false);
			result.put("total", getCount((BasicModel) t, list.size()));
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<Platformfavorable>());
			result.put("result", e.getMessage());
		}
		return result;
	}

	@RequestMapping(value = "/couponInsert")
	@ResponseBody
	public Map<String, Object> couponInsert(Platformfavorable entity, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			beforInsert(entity, request);
			beforUpsert(entity, request);
			User user = UserUtil.getUser(null);
			entity.setCreatedBy(user.getCreatedBy());
			entity.setLastUpdated(user.getLastUpdated());
			entity.setLastUpdatedBy(user.getLastUpdatedBy());
			entity.setActivityCode(keyGenerateService.keyo2oCode());
			entity.setId(keyGenerateService.keyGenerate());
			platformfavorableService.CouponInsert(entity);

			auditTrailInsert(entity, request, session, "N"); // 审计追踪新建记录

			Platformfavorable newEntry = platformfavorableService.queryActivityPageById(entity);
			result.put("newRow", newEntry);
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}

	public void beforInsert(Platformfavorable entity, HttpServletRequest request) throws Exception {
		if (entity.getPmoType() != null && entity.getPmoType() != "") {
			if (entity.getPmoType().equals("Cash Deduction") && entity.getDeducedCash() == "") {
				if (entity.getOnCouponName() != "" && entity.getOnCouponName() != null) {
					throw new BasicControllerException("当您选择减现金时，不能在加入优惠券");
				}
				throw new BasicControllerException("当您选择减现金时，优惠的金额不能为空");

			}

			if (entity.getPmoType().equals("Dispatch Coupon") && entity.getCouponName() == null
					&& entity.getCouponName() == "") {

				if (entity.getDeducedCash() != "" && entity.getDeducedCash() != null) {
					throw new BasicControllerException("当您选择送优惠券时，优惠的金额要为空");

				}
				throw new BasicControllerException("当您选择送优惠券时，请加入优惠券");
			}

		}

		int activityNum;
		// 平台优惠，不允许在同一个城市，同时间段内出现两个有效的。
		activityNum = platformfavorableService.queryActivityCount(entity);
		if (activityNum != 0) {
			throw new BasicControllerException("同一个城市,同时间段内只能有一个有效的促销活动");
		}
	}

	@RequestMapping(value = "/couponUpdate")
	@ResponseBody
	public Map<String, Object> couponUpdate(Platformfavorable entity, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			beforInsert(entity, request);
			beforUpsert(entity, request);
			User user = UserUtil.getUser(null);
			entity.setCreatedBy(user.getCreatedBy());
			entity.setLastUpdated(user.getLastUpdated());
			entity.setLastUpdatedBy(user.getLastUpdatedBy());
			platformfavorableService.CouponUpdate(entity);

			auditTrailInsert(entity, request, session, "N"); // 审计追踪新建记录

			Platformfavorable newEntry = platformfavorableService.queryActivityPageById(entity);
			result.put("newRow", newEntry);
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}

	@RequestMapping(value = "/updateCity")
	@ResponseBody
	public Map<String, Object> updateCity(Platformfavorable entity, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			beforInsert(entity, request);
			beforUpsert(entity, request);
			User user = UserUtil.getUser(null);
			entity.setCreatedBy(user.getCreatedBy());
			entity.setLastUpdated(user.getLastUpdated());
			entity.setLastUpdatedBy(user.getLastUpdatedBy());
			platformfavorableService.updateCity(entity);

			auditTrailInsert(entity, request, session, "N"); // 审计追踪新建记录

			Platformfavorable newEntry = getBasicService().queryById(entity);
			result.put("newRow", newEntry);
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}

	@RequestMapping("/queryCityPicklist")
	@ResponseBody
	public Map<String, Object> queryCityPicklist(QueryParams qps, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			qps.preDealSecurity(request);
			Platformfavorable t = (Platformfavorable) BasicModel.transformClass(Platformfavorable.class, qps);
			beforQueryAllOrExample(t, request);
			beforQueryExample(t, request);
			List<Platformfavorable> list = platformfavorableService.queryCityPicklistPage(t);
			result.put("success", true);
			result.put("rows", list);
			this.pushCurrentDataCache(list, session.getId(), "base", false);
			result.put("total", getCount((BasicModel) t, list.size()));
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<Platformfavorable>());
			result.put("result", e.getMessage());
		}
		return result;
	}

}
