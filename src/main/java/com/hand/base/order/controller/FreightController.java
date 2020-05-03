package com.hand.base.order.controller;

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
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.controller.BasicControllerException;
import com.hand.base.basic.model.BasicModel;
import com.hand.base.basic.service.BasicService;
import com.hand.base.o2oaddress.model.O2OAddress;
import com.hand.base.o2oaddress.service.O2OAddressService;
import com.hand.base.order.model.Freight;
import com.hand.base.order.service.FreightService;
import com.hand.core.basic.query.QueryParams;

@Controller
@RequestMapping("/action/portal/freight")
public class FreightController extends BasicController<Freight>{
	@Autowired
	private FreightService freightService;

	@Resource
	private O2OAddressService o2oAddressService;
	
	@Override
	public BasicService<Freight> getBasicService() throws Exception {
		return freightService;
	}
	
	/**
	 * 插入或更新前做操作
	 */
	public void beforUpsert(Freight entity, HttpServletRequest request) throws Exception{
		if(entity.getCityId() != null && !"".equals(entity.getCityId())){
			int count = freightService.countByCityIdAndName(entity);
			if(count > 0){
				throw new BasicControllerException("同一个城市下面不能维护相同名称的配送费模板");
			}
		}
	}
	
	/**
	 * 删除前做操作
	 */
	public void beforDelete(Freight entity, HttpServletRequest request) throws Exception{
		entity.setPageFlag(false);
		List<Freight> list = freightService.queryCsPage(entity);
		if(!list.isEmpty()){
			throw new BasicControllerException("该模版正在使用，无法删除！");
		}
	}
	

	/**
	 * 根据id查询商品范围,默认分页(若将'pageFlag'设置为'false'，则不分页)
	 */
	@RequestMapping(value = "/queryCsPage")
	@ResponseBody
	public Map<String, Object> queryCsPage(QueryParams qps, Freight entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			qps.preDealSecurity(request);
			Freight t = (Freight)BasicModel.transformClass(entity, qps);
			beforQueryAllOrExample(t,request);
			beforQueryExample(t,request);
			List<Freight> list = freightService.queryCsPage(entity);
			result.put("success", true);
			result.put("rows", list);
			this.pushCurrentDataCache(list, session.getId(), "base", false);
			result.put("total", getCount((BasicModel)t, list.size()));
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<Freight>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 根据id查询包邮区域,默认分页(若将'pageFlag'设置为'false'，则不分页)
	 */
	@RequestMapping(value = "/queryMaPage")
	@ResponseBody
	public Map<String, Object> queryMaPage(QueryParams qps, Freight entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			qps.preDealSecurity(request);
			Freight t = (Freight)BasicModel.transformClass(entity, qps);
			beforQueryAllOrExample(t,request);
			beforQueryExample(t,request);
			List<Freight> list = freightService.queryMaPage(entity);
			result.put("success", true);
			result.put("rows", list);
			this.pushCurrentDataCache(list, session.getId(), "base", false);
			result.put("total", getCount((BasicModel)t, list.size()));
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<Freight>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 根据id查询不包邮区域,默认分页(若将'pageFlag'设置为'false'，则不分页)
	 */
	@RequestMapping(value = "/queryNmaPage")
	@ResponseBody
	public Map<String, Object> queryNmaPage(QueryParams qps, Freight entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			qps.preDealSecurity(request);
			Freight t = (Freight)BasicModel.transformClass(entity, qps);
			t.setPageFlag(false);
			List<Freight> list=freightService.queryNmaPage(t);
			this.pushCurrentDataCache(list, session.getId(), "base", false);
			for(Freight freight : list){
				O2OAddress address = new O2OAddress();
				address.setAreaType("Province");
				String[] ids = freight.getAreaId().split(",");
				if(ids.length > 0){
					address.setIds(ids);
					List<O2OAddress> city = o2oAddressService.queryByExample(address);
					StringBuilder areaName = new StringBuilder();
					for(O2OAddress o2oaddress : city){
						if (areaName.length() > 0) {//该步即不会第一位有逗号，也防止最后一位拼接逗号！
							areaName.append(",");
			            }
						areaName.append(o2oaddress.getAreaName());
					}
					freight.setAreaName(areaName.toString());
				}
			}
			result.put("success", true);
			result.put("rows", list);
			this.pushCurrentDataCache(list, session.getId(), "base", false);
			result.put("total", getCount((BasicModel)t, list.size()));
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<Freight>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 新建一条记录
	 */
	@RequestMapping(value = "/nomailAreaUpsert")
	@ResponseBody
	@Transactional
	public Map<String, Object> nomailAreaUpsert(Freight entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			
			freightService.nomailAreaUpsert(entity);
			
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 查询一条记录
	 */
	@RequestMapping(value = "/queryDetailId")
	@ResponseBody
	public Map<String, Object> queryById(Freight entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			Freight record = freightService.queryById(entity);
			List<Freight> list = new ArrayList<Freight>();
			list.add(record);
			this.pushCurrentDataCache(list, session.getId(), "base", false);
			
			entity.setPageFlag(false);
			entity.setFreightId(entity.getId());
			List<Freight> ma=freightService.queryMaPage(entity);
			
			List<Freight> nma= freightService.queryNmaPage(entity);
			List<String> nmaList = new ArrayList<String>();
			if(nma.size() > 0){
				for(Freight freight : nma){
					String[] areas = freight.getAreaId().split(",");
					for(int i = 0 ; i < areas.length ; i++){
						nmaList.add(areas[i]);
					}
				}
			}
			O2OAddress address = new O2OAddress();
			address.setAreaType("Province");
			List<O2OAddress> city = o2oAddressService.queryByExample(address);
			for (int i = city.size() - 1; i >= 0; i--) {
				if(nmaList.contains(city.get(i).getId())){
					city.remove(city.get(i));
				}
			}
			
			result.put("result", record);
			result.put("ma", ma);
			result.put("city", city);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 查询剩余区域
	 */
	@RequestMapping(value = "/queryOtherArea")
	@ResponseBody
	public Map<String, Object> queryOtherArea(Freight entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			entity.setPageFlag(false);
			List<Freight> ma=freightService.queryMaPage(entity);
			List<String> list = new ArrayList<String>();
			if(ma.size() > 0){
				for(int i = 0 ; i<ma.size() ; i++){
					list.add(ma.get(i).getAreaId());
				}
			}
			List<Freight> nma= freightService.queryNmaPage(entity);
			if("updateNma".equals(entity.getAttr1())){
				entity.setAttr1("queryById");
				Freight record = freightService.queryNmaPage(entity).get(0);
				if(record != null){
					result.put("result", record);
					String areaId = record.getAreaId();
					if(areaId != null && !"".equals(areaId)){
					result.put("areas", areaId.split(","));
					}
				}
			}
			if(nma.size() > 0){
				for(Freight freight : nma){
					String[] areas = freight.getAreaId().split(",");
					for(int i = 0 ; i < areas.length ; i++){
						list.add(areas[i]);
					}
				}
			}
			O2OAddress address = new O2OAddress();
			address.setAreaType("Province");
			List<O2OAddress> city = o2oAddressService.queryByExample(address);
			for (int i = city.size() - 1; i >= 0; i--) {
				if(list.contains(city.get(i).getId())){
					city.remove(city.get(i));
				}
			}
			result.put("city", city);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
}
