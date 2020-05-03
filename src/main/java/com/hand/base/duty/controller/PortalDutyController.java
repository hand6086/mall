package com.hand.base.duty.controller;

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
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.model.BasicModel;
import com.hand.base.basic.service.BasicService;
import com.hand.base.common.model.InterObject;
import com.hand.base.common.model.Menu;
import com.hand.base.duty.model.Duty;
import com.hand.base.duty.service.DutyService;
import com.hand.base.urlinfo.model.UrlInfo;
import com.hand.base.user.model.User;
import com.hand.core.basic.query.Filter;
import com.hand.core.basic.query.QueryParams;


@Controller
@RequestMapping("/action/portal/duty")
public class PortalDutyController extends BasicController<Duty> {

	private static final Logger logger = LogManager.getLogger(PortalDutyController.class);
	
	@Resource
	private DutyService dutyService;
	
	@Override
	public BasicService<Duty>  getBasicService() throws Exception{
		return dutyService;
	}
	
	/**
	 * 查询职责列表，如果是000账套，则去除cropid限制
	 */
	@RequestMapping(value = "/queryDutyListPage")
	@ResponseBody
	public Map<String, Object> queryDutyListPage(QueryParams qps, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			qps.preDealSecurity(request);
			Duty t = (Duty)BasicModel.transformClass(Duty.class, qps);
			beforQueryAllOrExample(t,request);
			beforQueryExample(t,request);
			List<Duty> list = dutyService.queryDutyListPage(t);
			result.put("success", true);
			result.put("rows", list);
			this.pushCurrentDataCache(list, session.getId(), "base", false);
			result.put("total", getCount((BasicModel)t, list.size()));
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<Duty>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 根据职责ID查询二级菜单,用于职责页面中的菜单列表显示
	 */
	@RequestMapping(value = "/dutyOfMenuList", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> dutyOfMenuList(QueryParams qps, HttpSession session, HttpServletRequest request,HttpServletResponse response){
		Map<String, Object> result = new HashMap<String, Object>();
		List<Menu> list = new ArrayList<Menu>();
		try{
			qps.preDealSecurity(request);
			qps.invokePreFilterAndSorter();
			List<Filter> filterList = qps.getFilterByProperty("dutyId");
			if(filterList == null || filterList.size() == 0){
				qps.addFilter(new Filter("dutyId","noMatchId"));
			}
			qps.addFilter(new Filter("menuGrade","1"));
			Menu t = (Menu)BasicModel.transformClass(Menu.class, qps);
			list = dutyService.queryDutyOfMenuListPage(t);
			result.put("success", true);
			result.put("rows", list);
//			this.pushCurrentDataCache(list, session.getId(), "base", false);
			result.put("total", getCount((BasicModel)t, list.size()));
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", list);
			result.put("total", qps.getTotal());
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value = "/subMenuDutySelect", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> subMenuDutyPage(QueryParams qps, HttpSession session, HttpServletRequest request,HttpServletResponse response){
		Map<String, Object> result = new HashMap<String, Object>();
		List<Menu> list = new ArrayList<Menu>();
		try{
			qps.preDealSecurity(request);
			qps.invokePreFilterAndSorter();
			List<Filter> filterList = qps.getFilterByProperty("dutyId");
			if(filterList == null || filterList.size() == 0){
				qps.addFilter(new Filter("dutyId","noMatchId"));
			}
			List<Filter> parentMenuIdfilter = qps.getFilterByProperty("parentMenuId");
			if(parentMenuIdfilter == null || parentMenuIdfilter.size() == 0){
				qps.addFilter(new Filter("parentMenuId","noMatchId"));
			}
			qps.addFilter(new Filter("menuGrade","2"));
			qps.setPageFlag(false);
			Menu t = (Menu)BasicModel.transformClass(Menu.class, qps);
			list = dutyService.queryDutyOfMenuListPage(t);
//			this.pushCurrentDataCache(list, session.getId(), "base", false);
			result.put("success", true);
			result.put("rows", list);
			result.put("total", getCount((BasicModel)t, list.size()));
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", list);
			result.put("total", qps.getTotal());
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value = "/dutyOfUserList", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> dutyOfUserList(User record, QueryParams qps, HttpSession session, HttpServletRequest request,HttpServletResponse response){
		Map<String, Object> result = new HashMap<String, Object>();
		List<User> list = null;
		try{
			qps.invokePreFilterAndSorter();
			List<Filter> filterList = qps.getFilterByProperty("dutyId");
			if(filterList == null || filterList.size() == 0){
				qps.addFilter(new Filter("dutyId","noMatchId"));
			}
			User t = (User)BasicModel.transformClass(User.class, qps);
			list = dutyService.queryDutyOfUserListPage(t);
//			this.pushCurrentDataCache(list, session.getId(), "base", false);
			result.put("success", true);
			result.put("rows", list);
			result.put("total", getCount((BasicModel)t, list.size()));
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value = "/unSelectMenuList", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> unSelectMenuList(Duty record, QueryParams qps, HttpSession session, HttpServletRequest request,HttpServletResponse response){
		Map<String, Object> result = new HashMap<String, Object>();
		/*List<Menu> list = null;
		qps.setAttr1(record.getId());
		try{
			Enterprise enterprise = (Enterprise) session.getAttribute("UserEnterpriseContext");
			String industryVersion = enterprise.getIndustryVersion();
 			if(StringUtils.isBlank(industryVersion)){
				throw new Exception("企业的行业版本信息有误，请联系管理员");
			}
			 注意，industryVersion(企业表里的行业版本字段的值)与菜单表相应的行业字段必须一一对应，对应关系请
			 * 对照Menu对象的相应字段和值列表中类型为INDUSTRY_VERSION的记录的独立源代码
			 
			qps.addFilter(new Filter(industryVersion, "Y"));
			
			Menu t = (Menu)BasicModel.transformClass(Menu.class, qps);
			list = dutyService.queryUnSelectMenuListPage(t);
			result.put("success", true);
			result.put("rows", list);
			result.put("total", getCount((BasicModel)t, list.size()));
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}*/
		List<Menu> list = null;
		try{
			qps.setAttr1(record.getId());
			Menu t = (Menu)BasicModel.transformClass(Menu.class, qps);
			list = dutyService.queryUnSelectMenuListPage(t);
			result.put("success", true);
			result.put("rows", list);
			result.put("total", getCount((BasicModel)t, list.size()));
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value = "/unSelectSubMenuList", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> unSelectSubMenuList(String dutyId,String menuItemId, QueryParams qps, HttpSession session, HttpServletRequest request,HttpServletResponse response){
		Map<String, Object> result = new HashMap<String, Object>();
		List<Menu> list = null;
		try{
			qps.setAttr1(dutyId);
			qps.addFilter(new Filter("parentMenuId",menuItemId));
			Menu t = (Menu)BasicModel.transformClass(Menu.class, qps);
			list = dutyService.queryUnSelectSubMenuListPage(t);
			result.put("success", true);
			result.put("rows", list);
			result.put("total", getCount((BasicModel)t, list.size()));
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value = "/addMenuOfDuty", method = RequestMethod.POST)
	@ResponseBody
	@Transactional
	public Map<String, Object> addMenuOfDuty(@RequestBody List<InterObject> list, QueryParams qps, HttpSession session, HttpServletRequest request,HttpServletResponse response){
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			for(int i=0; list != null && i<list.size(); i++){
				InterObject record = list.get(i);
				Menu menu = new Menu();
				menu.setDutyId(record.getPreObjId());
				menu.setId(record.getRearObjId());
				dutyService.addMenuOfDutyInsert(menu);
			}
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value = "/delMenuOfDuty", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> delMenuOfDuty(InterObject record, QueryParams qps, HttpSession session, HttpServletRequest request,HttpServletResponse response){
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			dutyService.delMenuOfDuty(record);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value = "/unSelectUserList", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> unSelectUserList(User record, QueryParams qps, HttpSession session, HttpServletRequest request,HttpServletResponse response){
		Map<String, Object> result = new HashMap<String, Object>();
		List<User> list = null;
		qps.setAttr1(record.getId());
		try{
			User t = (User)BasicModel.transformClass(User.class, qps);
			list = dutyService.queryUnSelectUserListPage(t);
			result.put("success", true);
			result.put("rows", list);
			result.put("total", getCount((BasicModel)t, list.size()));
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value = "/addUserOfDuty", method = RequestMethod.POST)
	@ResponseBody
	@Transactional
	public Map<String, Object> addUserOfDuty(@RequestBody List<InterObject> list, QueryParams qps, HttpSession session, HttpServletRequest request,HttpServletResponse response){
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			for(int i=0; list != null && i<list.size(); i++){
				InterObject record = list.get(i);
				User user = new User();
				user.setDutyId(record.getPreObjId());
				user.setId(record.getRearObjId());
				dutyService.addUserOfDutyInsert(user);
			}
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value = "/delUserOfDuty", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> delUserOfDuty(InterObject record, QueryParams qps, HttpSession session, HttpServletRequest request,HttpServletResponse response){
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			dutyService.delUserOfDuty(record);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 
	 *<p>更新职责菜单表</p>
	 * @author yrf
	 * @param record
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/updateMenuOfDuty", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateUserOfDuty(Menu record,HttpSession session){
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			dutyService.menuOfDutyUpdate(record);
			record.setPageFlag(false);
			List<Menu> list = dutyService.queryDutyOfMenuListPage(record);
			if(list != null && list.size() == 1){
				result.put("newRow", list.get(0));
			}
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 
	 *<p>批量更新职责下菜单信息</p>
	 * @author yrf
	 * @param list
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/batchUpdateMenuOfDuty", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> batchUpdateUserOfDuty(@RequestBody List<Menu> list,HttpSession session){
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			if(list != null && list.size()>0){
				for(Menu record : list){
					dutyService.menuOfDutyUpdate(record);
				}
			}
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 
	 *<p>查询未关联职责的url</p>
	 * @author yrf
	 * @param record
	 * @param qps
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/unSelectUrlList", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> unSelecturlList(UrlInfo record, QueryParams qps, HttpSession session, HttpServletRequest request,HttpServletResponse response){
		Map<String, Object> result = new HashMap<String, Object>();
		List<UrlInfo> list = null;
		//qps.setAttr1(record.getId());
		try{
			UrlInfo t = (UrlInfo)BasicModel.transformClass(UrlInfo.class, qps);
			list = dutyService.queryUnSelectUrlListPage(t);
			result.put("success", true);
			result.put("rows", list);
			result.put("total", getCount((BasicModel)t, list.size()));
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	/**
	 * picklist查询000公司帐套信息
	 */
	@RequestMapping(value = "/queryStandardPage")
	@ResponseBody
	public Map<String, Object> queryStandardPage(QueryParams qps, Duty entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			qps.preDealSecurity(request);
			Duty t = (Duty)BasicModel.transformClass(entity.getClass(), qps);
			beforQueryAllOrExample(t,request);
			beforQueryExample(t,request);
			t.setUsercorpid("000");
			List<Duty> list = getBasicService().queryByExamplePage(t);
			result.put("success", true);
			result.put("rows", list);
			this.pushCurrentDataCache(list, session.getId(), "base", false);
			result.put("total", getCount((BasicModel)t, list.size()));
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<Duty>());
			result.put("result", e.getMessage());
		}
		return result;
	}
}
