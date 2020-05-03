package com.hand.base.coupon.controller;

import java.lang.reflect.Method;
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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.controller.BasicControllerException;
import com.hand.base.basic.model.BasicModel;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.basic.service.KeyGenerateService;
import com.hand.base.common.model.Announce;
import com.hand.base.coupon.model.Coupon;
import com.hand.base.coupon.service.CouponService;
import com.hand.core.basic.query.QueryParams;
import com.hand.core.util.Constants;
import com.hand.core.util.UserUtil;

@Controller
@RequestMapping("/action/portal/coupon")
public class CouponController extends BasicController<Coupon> {
	@Autowired
	private CouponService couponService;
	@Resource
	private KeyGenerateService keyGenerateService;

	public BasicService<Coupon> getBasicService() throws Exception {
		return couponService;
	}
	
	@RequestMapping(value = "/newInit/{couponType}")
	public String newInit( @PathVariable String couponType, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("couponType", couponType);
		return "brandShop/brandCouponNew";
	}
	
	@RequestMapping("/querycouponinformation")
	@ResponseBody
	public Map<String, Object> querycouponinformation(QueryParams qps, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		String searchParam = qps.getSearchParam();
		String searchValue = qps.getSearchValue();
		try {
			
			qps.preDealSecurity(request);
			Coupon t = (Coupon) BasicModel.transformClass(Coupon.class, qps);

			beforQueryAllOrExample(t, request);
			beforQueryExample(t, request);
			
			if("MY_ORG".equals(t.getOauth())){
				t.setOrgId(UserUtil.getUser(null).getOrgId());
			}
			
			if(searchParam != null){
				String startStr = searchParam.substring(0,1);
				
				Method setIdMethod = Coupon.class.getMethod("set" + startStr.toUpperCase() + searchParam.substring(1), new Class[] { String.class });
				setIdMethod.invoke(t, searchValue);
			}
			List<Coupon> list = new ArrayList<Coupon>();
			if(qps.getOnlyCountFlag()){
				result.put("success", true);
				int count = couponService.querycouponinformationCount(t);
				Coupon coupon = new Coupon();
				coupon.setTotal(count);
				list.add(coupon);
				result.put("rows", list);
			}else{
				
				list = couponService.querycouponinformation(t);
				result.put("success", true);
				result.put("rows", list);
				this.pushCurrentDataCache(list, session.getId(), "base", false);
				result.put("total", getCount((BasicModel) t, list.size()));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<Coupon>());
			result.put("result", e.getMessage());
		}
		return result;
	}

	@RequestMapping("/queryConsumerInformationPage")
	@ResponseBody
	public Map<String, Object> queryconsumerinformationPage(QueryParams qps, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			qps.preDealSecurity(request);
			Coupon t = (Coupon) BasicModel.transformClass(Coupon.class, qps);

			beforQueryAllOrExample(t, request);
			beforQueryExample(t, request);
			List<Coupon> list = couponService.queryConsumerInformationPage(t);
			result.put("success", true);
			result.put("rows", list);
			this.pushCurrentDataCache(list, session.getId(), "base", false);
			result.put("total", getCount((BasicModel) t, list.size()));
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<Coupon>());
			result.put("result", e.getMessage());
		}
		return result;
	}

	@RequestMapping(value = "/customerInsert")
	@ResponseBody
	public Map<String, Object> customerInsert(Coupon entity, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			beforInsert(entity, request);
			beforUpsert(entity, request);
			entity.setId(keyGenerateService.keyGenerate());
			couponService.customerInsert(entity);
			auditTrailInsert(entity, request, session, "N"); // 审计追踪新建记录
			Coupon newEntry = couponService.queryconsumerById(entity);
			result.put("newRow", newEntry);
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}

	@RequestMapping(value = "/customerUpdate")
	@ResponseBody
	public Map<String, Object> customerUpdate(QueryParams qps, Coupon entity, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			beforInsert(entity, request);
			beforUpsert(entity, request);
			entity.setHeadId(qps.getId());
			couponService.customerUpdate(entity);
			auditTrailInsert(entity, request, session, "N"); // 审计追踪新建记录
			Coupon newEntry = couponService.queryconsumerById(entity);
			result.put("newRow", newEntry);
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}

	/*@RequestMapping("/querygoodsinformationPage")
	@ResponseBody
	public Map<String, Object> querygoodsinformationPage(QueryParams qps, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			qps.preDealSecurity(request);
			Coupon t = (Coupon) BasicModel.transformClass(Coupon.class, qps);
			beforQueryAllOrExample(t, request);
			beforQueryExample(t, request);
			List<Coupon> list = couponService.querygoodsinformationPage(t);
			result.put("success", true);
			result.put("rows", list);
			this.pushCurrentDataCache(list, session.getId(), "base", false);
			result.put("total", getCount((BasicModel) t, list.size()));
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<Coupon>());
			result.put("result", e.getMessage());
		}
		return result;
	}*/
	
	/**
	 * 对数据进行校验
	 * @param entity
	 * @param request
	 */
	private void check(Coupon entity, HttpServletRequest request){
		if("No Constrain".equals(entity.getRestriction()))
		{
			String minOrdPrice = entity.getMinOrdPrice();
			try{
				if(Double.valueOf(minOrdPrice) > 0 || Double.valueOf(minOrdPrice) < 0){
					throw new BasicControllerException("使用金额无门槛限制时，订单满金额必须为0！");
				}
			}catch(Exception e){
				throw new BasicControllerException("订单满金额输入非法！");
			}
			
		}
	}

	@RequestMapping(value = "/couponinformationInsert")
	@ResponseBody
	public Map<String, Object> couponinformationInsert(Coupon entity, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			check(entity, request);
			beforInsert(entity, request);
			beforUpsert(entity, request);
			couponService.couponinformationInsert(entity);
			auditTrailInsert(entity, request, session, "N"); // 审计追踪新建记录
			Coupon newEntry = couponService.queryCouponById(entity);
			result.put("newRow", newEntry);
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	public void beforInsert(Coupon entity,HttpServletRequest request){
	
	}
	public void beforUpsert(Coupon entity,HttpServletRequest request){
		
	}
	/*@RequestMapping(value = "/goodsInsert")
	@ResponseBody
	public Map<String, Object> goodsInsert(QueryParams qps, Coupon entity, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			beforInsert(entity, request);
			beforUpsert(entity, request);
			entity.setHeadId(qps.getId());
			entity.setId(keyGenerateService.keyGenerate());
			couponService.goodsInsert(entity);
			auditTrailInsert(entity, request, session, "N"); // 审计追踪新建记录
			Coupon newEntry = couponService.querygoodsinformationById(entity);
			result.put("newRow", newEntry);
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}*/

	@RequestMapping(value = "/couponUpdate")
	@ResponseBody
	public Map<String, Object> couponUpdate(QueryParams qps, Coupon entity, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			check(entity, request);
			beforInsert(entity, request);
			beforUpsert(entity, request);
			entity.setHeadId(qps.getId());
			couponService.CouponUpdate(entity);
			auditTrailInsert(entity, request, session, "N"); // 审计追踪新建记录
			Coupon newEntry = couponService.queryCouponById(entity);
			result.put("newRow", newEntry);
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}

	/*@RequestMapping(value = "/goodsUpdate")
	@ResponseBody
	public Map<String, Object> goodsUpdate(QueryParams qps, Coupon entity, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			beforInsert(entity, request);
			beforUpsert(entity, request);
			entity.setHeadId(qps.getId());
			couponService.goodsUpdate(entity);
			auditTrailInsert(entity, request, session, "N"); // 审计追踪新建记录
			Coupon newEntry = couponService.querygoodsinformationById(entity);
			result.put("newRow", newEntry);
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}*/

	@RequestMapping("/customerPlistPage")
	@ResponseBody
	public Map<String, Object> customerPlistPage(QueryParams qps, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			qps.preDealSecurity(request);
			Coupon t = (Coupon) BasicModel.transformClass(Coupon.class, qps);
			beforQueryAllOrExample(t, request);
			beforQueryExample(t, request);
			List<Coupon> list = couponService.customerPlistPage(t);
			result.put("success", true);
			result.put("rows", list);
			this.pushCurrentDataCache(list, session.getId(), "base", false);
			result.put("total", getCount((BasicModel) t, list.size()));
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<Coupon>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value = "/count", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> count(QueryParams qps, Coupon entity,HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			check(entity, request);
			couponService.count(entity);
			Coupon newEntry = couponService.queryCouponById(entity);
			result.put("result", newEntry);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
}
