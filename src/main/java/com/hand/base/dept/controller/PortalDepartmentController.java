package com.hand.base.dept.controller;

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
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.dept.model.Department;
import com.hand.base.dept.service.DepartmentService;
import com.hand.core.basic.query.Filter;
import com.hand.core.basic.query.QueryParams;
import com.hand.core.basic.query.Sorter;
import com.hand.core.util.StringUtils;

@Controller
@RequestMapping("/action/portal/dept")
public class PortalDepartmentController extends BasicController<Department> {
	private static final Logger logger = LogManager.getLogger(PortalDepartmentController.class);
	
	@Resource
	private DepartmentService departmentService;
	
	@Override
	public BasicService<Department>  getBasicService() throws Exception{
		return departmentService;
	}
	
	/**
	 * 加载树
	 */
	@RequestMapping(value = "/treelist", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> treelist(QueryParams qps, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			Department root = departmentService.queryRoot(new Department());
			departmentService.queryTreeByRoot(root);
			result.put("success", true);
			result.put("tree", true);
			result.put("list", root);//传根节点
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("list", new Department());
			result.put("result", e.getMessage());
		}
		return result;
	}
	/**
	 * 加载结构框图树
	 */
	@RequestMapping(value = "/treelist/{initDeptId}")
	@ResponseBody
	public Department treelist(@PathVariable String initDeptId,QueryParams qps, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Department root = new Department(); 
		try{
			root.setId(initDeptId);
			root = departmentService.queryById(root);
			departmentService.queryTreeByRoot1(root);
		}catch(Exception e){
			e.printStackTrace();
		}
		return root;
	}
	/**
	 * 选择父对象时的picklist
	 */
	@RequestMapping(value = "/parentPicklist", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> parentPicklist(Department entity, QueryParams qps, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			qps.addSorter(new Sorter("created",Sorter.DIR_DESC));//按创建时间来排序
			if(StringUtils.equals(qps.getAttr1(), "Y")){//如果是组织
				qps.addFilter(new Filter("isOrg", qps.getAttr1()));
			}
			Department t = (Department)BasicModel.transformClass(Department.class, qps);
			t.preDealSecurity(request);//设置安全性
			List<Department> list = departmentService.queryDepartmentListRemoveIdAndChildrenPage(t);
			result.put("success", true);
			result.put("rows", list);
			result.put("total", getCount(((BasicModel)t), list.size()));
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<Department>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 通用picklist
	 */
	@RequestMapping(value = "/picklist", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> picklist(QueryParams qps, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			Department t = (Department)BasicModel.transformClass(Department.class, qps);
			t.preDealSecurity(request);//设置安全性
			List<Department> list = departmentService.queryByExamplePage(t);
			result.put("success", true);
			result.put("rows", list);
			result.put("total", getCount(((BasicModel)t), list.size()));
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<Department>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 根据ID删除该记录以及其子对象
	 */
	@RequestMapping(value = "/deleteWithChildById")
	@ResponseBody
	public Map<String, Object> deleteWithChildById(Department entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		logger.info("根据ID删除该记录以及其子对象信息...");
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			beforDelete(entity, request);
			checkData(entity, request);
			if(!checkExistDataCache("base", session, entity)){
				throw new BasicServiceException("非法删除数据！");
			}
			departmentService.deleteWithChildById(entity);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		
		return result;
	}

	public void beforUpsert(Department entity, HttpServletRequest request){
		entity.setIsOrg("N");
	}
}
