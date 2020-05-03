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
import com.hand.base.goods.model.Goods;
import com.hand.base.o2oaccnt.model.Address;
import com.hand.base.o2oaccnt.model.Area;
import com.hand.base.o2oaccnt.service.AddressService;
import com.hand.base.o2odataimport.model.RestaurantTemp;
import com.hand.base.user.model.User;
import com.hand.core.basic.query.QueryParams;
import com.hand.core.util.HttpUtils;
import com.hand.core.util.UserUtil;

@Controller()
@RequestMapping("/action/portal/address")
public class AddressController extends BasicController<Address> {
	@Resource
	private AddressService addressService;

	public BasicService<Address> getBasicService() {
		return addressService;
	}
	
	@RequestMapping(value = "/custmNamePickListPage", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> parentAreaPickList(Address record, QueryParams qps, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			Address t = (Address)BasicModel.transformClass(record, qps);
			List<Address> list = addressService.custmNamePickListPage(t);
			t.preDealSecurity(request);
			result.put("success", true);
			result.put("rows", list);
			result.put("total", getCount(((BasicModel) t), list.size()));
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<Address>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 查询 地址标签 下拉列表
	 * @param qps
	 * @return
	 */
	@RequestMapping(value = "/labelNamePickList")
	@ResponseBody
	public List<Address> labelNamePickList(QueryParams qps,Address entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		List<Address> list = null;
		try{
			Address t = (Address)BasicModel.transformClass(entity, qps);
			list = addressService.labelNamePickListAll(t);
		}catch(Exception e){
			e.printStackTrace();
		}
		return list;
	}
	
	@RequestMapping(value = "/updateLatLng", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateLatLng(Address entity, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			entity = addressService.queryById(entity);
			
			String logistics = entity.getProvince()+entity.getCity()+entity.getDistrict()+entity.getAddress();
			Map<String, Double> map = HttpUtils.getLngAndLat(logistics);
			Double longtitude = map.get("longtitude");
			Double latitude = map.get("latitude");
			entity.setGpsLong(String.valueOf(longtitude));
			entity.setGpsLat(String.valueOf(latitude));
			addressService.update(entity);
		
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
}
