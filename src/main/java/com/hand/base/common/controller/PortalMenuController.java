package com.hand.base.common.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.model.BasicModel;
import com.hand.base.basic.service.BasicService;
import com.hand.base.common.model.Menu;
import com.hand.base.common.service.MenuService;
import com.hand.core.basic.query.Filter;
import com.hand.core.basic.query.QueryParams;
import com.hand.core.modules.export.ExportFactory;
import com.hand.core.modules.export.ExportWriter;

@Controller
@RequestMapping("/action/portal/menu")
public class PortalMenuController extends BasicController<Menu>{
	private static final Logger logger = LogManager.getLogger(PortalMenuController.class);
	@Resource
	private MenuService menuService;
	
	@Override
	public BasicService<Menu> getBasicService() throws Exception{
		return menuService;
	}
	
	@RequestMapping(value = "/noMatchId", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> noMatchId(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Menu> list = null;
		try{
			list = new ArrayList<Menu>();
			result.put("success", true);
			result.put("rows", list);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value = "/manageInit/{type}", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> manageInit(@PathVariable String type, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Menu> list = null;
		try{
			if(type.equals("657676")){//查询所有二级菜单，ACSII码ALL
				type = "";
			}
			list = menuService.getMenuListByMenuTyepSelect(type,session);
			result.put("success", true);
			result.put("rows", list);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value = "siteMap")
	public String siteMap(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		List<Menu> list = menuService.getMenuListByMenuTyepSelect("",session);
		request.setAttribute("sList", list);
		return "sitemap/navi";
	}
	
	/**
	 * 查询一级菜单
	 */
	@RequestMapping(value = "/queryFstLevel")
	@ResponseBody
	public Map<String, Object> queryFstLevel(QueryParams qps, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			qps.addFilter(new Filter("menuGrade", "0"));
			Menu t = (Menu)BasicModel.transformClass(Menu.class, qps);
			List<Menu> list = getBasicService().queryByExamplePage(t);
			result.put("success", true);
			result.put("rows", list);
			this.pushCurrentDataCache(list, session.getId(), "base", false);
			result.put("total", getCount(t, list.size()));
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<Menu>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	/**
	 * 一级菜单导出
	 */
	@Override
	@RequestMapping(value = "/queryFstLevel/exportData")
	@ResponseBody
	public Map<String, Object> exportData(Menu entity, QueryParams qps, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		logger.info("导出列表...");
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			qps.preDealSecurity(request);
			qps.addFilter(new Filter("menuGrade", "0"));
			ExportWriter exportWriter = ExportFactory.newInstance(qps);
			Menu t = (Menu)BasicModel.transformClass(entity.getClass(), qps);
			List<Menu> list = getBasicService().queryByExamplePage(t);
			while(!qps.stopExport){
				exportWriter.wirteData(list);
			}
			result.put("success", true);
			result.put("url", exportWriter.getUrlPath());
			//result.put("total", getCount((BasicModel)t, list.size()));
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	@RequestMapping(value = "/items")
	@ResponseBody
	public Map<String, Object> items(QueryParams qps, HttpSession session, HttpServletRequest request,HttpServletResponse response){
		Map<String, Object> result = new HashMap<String, Object>();
		List<Menu> list = new ArrayList<Menu>();
		try{
			qps.preDealSecurity(request);
			qps.invokePreFilterAndSorter();
			List<Filter> filterList = qps.getFilterByProperty("menuType");
			if(filterList == null || filterList.size() == 0){
				qps.addFilter(new Filter("menuType","noMatchId"));
			}
			
			Menu t = (Menu) BasicModel.transformClass(Menu.class, qps);
			beforQueryAllOrExample(t,request);
			beforQueryExample(t,request);
			list = getBasicService().queryByExamplePage(t);
			result.put("success", true);
			result.put("rows", list);
			this.pushCurrentDataCache(list, session.getId(), "base", false);
			result.put("total", getCount(t, list.size()));
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", list);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value = "/subItemList")
	@ResponseBody
	public Map<String, Object> subItemList(QueryParams qps, HttpSession session, HttpServletRequest request,HttpServletResponse response){
		Map<String, Object> result = new HashMap<String, Object>();
		List<Menu> list = new ArrayList<Menu>();
		try{
			qps.invokePreFilterAndSorter();
			List<Filter> filterList = qps.getFilterByProperty("parentMenuId");
			if(filterList == null || filterList.size() == 0){
				qps.addFilter(new Filter("parentMenuId","noMatchId"));
			}
			Menu t = (Menu) BasicModel.transformClass(Menu.class, qps);
			beforQueryAllOrExample(t,request);
			beforQueryExample(t,request);
			list = getBasicService().queryByExamplePage(t);
			result.put("success", true);
			result.put("rows", list);
			this.pushCurrentDataCache(list, session.getId(), "base", false);
			result.put("total", getCount(t, list.size()));
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", list);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value = "/addBefore", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> addBefore(Menu record, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			Menu menu = menuService.queryByMenuType(record.getMenuType());
			if(menu != null){
				result.put("success", false);
				result.put("result", "该菜单类型：" + record.getMenuType() + "已经存在！");
			}else{
				result.put("success", true);
			}
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
}
