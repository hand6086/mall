package com.hand.base.o2oaccnt.controller;

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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.model.BasicModel;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.KeyGenerateService;
import com.hand.base.coupon.model.Coupon;
import com.hand.base.enterprise.model.Enterprise;
import com.hand.base.enterprise.service.EnterpriseService;
import com.hand.base.goods.model.Goods;
import com.hand.base.o2oaccnt.model.Area;
import com.hand.base.o2oaccnt.model.Store;
import com.hand.base.o2oaccnt.model.StoreInfo;
import com.hand.base.o2oaccnt.service.StoreService;
import com.hand.base.user.model.User;
import com.hand.core.basic.query.QueryParams;
import com.hand.core.util.UserUtil;

@Controller()
@RequestMapping("/action/portal/store")
public class StoreController extends BasicController<Store>{
	@Resource
	private StoreService storeService;
	@Resource
	private EnterpriseService enterpriseService;
	@Resource
	private KeyGenerateService keyGenService;
	@Override
	public BasicService<Store> getBasicService(){
		return storeService;
	}
	

	@RequestMapping(value = "/queryAccntBycode", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> queryAccntBycode(QueryParams qps,Store record, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			Store t = (Store) BasicModel.transformClass(record, qps);
			List<Store> list = storeService.queryAccntBycode(t);
			result.put("rows", list);
			result.put("success", true);
			this.pushCurrentDataCache(list, session.getId(), "base", false);
			result.put("total", getCount((BasicModel)t, list.size()));
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
			
		}
		return result;
	}

	
	@RequestMapping(value = "/qureyAccentDetail", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> qureyAccentDetail(QueryParams qps,Store record, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			Store t = (Store) BasicModel.transformClass(record, qps);
			Store t1 = storeService.qureyAccentDetail(t);
			result.put("success", true);
			result.put("rows", t1);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<Area>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	
	@RequestMapping(value = "/provincePickListPage", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> provincePickList(QueryParams qps,Store record, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			Store t = (Store) BasicModel.transformClass(record, qps);
			List<Store> list = storeService.provincePickListPage(t);
			result.put("success", true);
			result.put("rows", list);
			result.put("total", getCount(((BasicModel) t), list.size()));
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<Area>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value = "/cityPickListPage", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> cityPickList(QueryParams qps,Store record, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			Store t = (Store) BasicModel.transformClass(record, qps);
			List<Store> list = storeService.cityPickListPage(t);
			result.put("success", true);
			result.put("rows", list);
			result.put("total", getCount(((BasicModel) t), list.size()));
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<Area>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value = "/districtPickListPage", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> districtPickList(QueryParams qps,Store record, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			Store t = (Store) BasicModel.transformClass(record, qps);
			List<Store> list = storeService.districtPickListPage(t);
			result.put("success", true);
			result.put("rows", list);
			result.put("total", getCount(((BasicModel) t), list.size()));
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<Area>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	/**
	 * 查询注册商户申请信息
	 */
	@RequestMapping(value = "/queryStoreInfo", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> queryStoreInfo(QueryParams qps,StoreInfo record, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			StoreInfo t = (StoreInfo) BasicModel.transformClass(record, qps);
			List<StoreInfo> list = storeService.queryStoreInfo(record);
			
			User user = UserUtil.getUser(null);
			
			Enterprise enterprise =new Enterprise();
			StoreInfo store=list.get(0);
			enterprise.setUserId(user.getId());
			//enterprise.setCorpid("101");
			enterprise.setName(store.getCompanyName());
			enterprise.setCode(keyGenService.corpIdGenerate());
			enterprise.setAttr2(store.getApplicantName());
			enterprise.setRow_status("NEW");
			
			enterpriseService.upsert(enterprise);
			enterpriseService.dutyInsert(enterprise);
			enterpriseService.defaultMenuInsert(enterprise);
			//enterpriseService.dutyUser(enterprise);
			//enterpriseService.dutyUpdate(enterprise);
			result.put("success", true);
			result.put("rows", list);
			result.put("total", getCount(((BasicModel) t), list.size()));
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<StoreInfo>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	
}
