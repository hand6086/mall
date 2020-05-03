package com.hand.base.orgnization.controller;

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
import com.hand.base.basic.model.CallParam;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.BasicServiceException;

import com.hand.base.orgnization.model.Orgnization;
import com.hand.base.orgnization.service.OrgnizationService;
import com.hand.core.basic.query.Filter;
import com.hand.core.basic.query.QueryParams;
import com.hand.core.basic.query.Sorter;
import com.hand.core.util.StringUtils;
import com.hand.core.util.UserUtil;

@Controller
@RequestMapping("/action/portal/orgnization")
public class PortalOrgnizationController extends BasicController<Orgnization> {
	private static final Logger logger = LogManager.getLogger(PortalOrgnizationController.class);
	@Resource
	private OrgnizationService orgnizationService;
	
	@Override
	public BasicService<Orgnization>  getBasicService() throws Exception{
		return orgnizationService;
	}
	

	
	
	
	/**
	 * 加载树
	 */
	@RequestMapping(value = "/treelist", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> treelist(QueryParams qps, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			Orgnization root = orgnizationService.queryRoot(new Orgnization());
			orgnizationService.queryTreeByRoot(root);
			result.put("success", true);
			result.put("tree", true);
			result.put("list", root);//传根节点
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("list", new Orgnization());
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 加载结构框图树
	 */
	@RequestMapping(value = "/treelist/{initOrgId}")
	@ResponseBody
	public Orgnization treelist(@PathVariable String initOrgId,QueryParams qps, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Orgnization root = new Orgnization(); 
		try{
			root.setId(initOrgId);
			root = orgnizationService.queryById(root);
			orgnizationService.queryTreeByRoot1(root);
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
	public Map<String, Object> parentPicklist(Orgnization entity, QueryParams qps, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			qps.addSorter(new Sorter("created",Sorter.DIR_DESC));//按创建时间来排序
			if(StringUtils.equals(qps.getAttr1(), "Y")){//如果是组织
				qps.addFilter(new Filter("isOrg", qps.getAttr1()));
			}
			Orgnization t = (Orgnization)BasicModel.transformClass(Orgnization.class, qps);
			t.preDealSecurity(request);
			List<Orgnization> list = orgnizationService.queryListRemoveIdAndChildrenPage(t);
			result.put("success", true);
			result.put("rows", list);
			result.put("total", getCount(((BasicModel)t), list.size()));
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<Orgnization>());
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
			Orgnization t = (Orgnization)BasicModel.transformClass(Orgnization.class, qps);
			t.preDealSecurity(request);
			List<Orgnization> list = orgnizationService.queryByExamplePage(t);
			result.put("success", true);
			result.put("rows", list);
			result.put("total", getCount(((BasicModel)t), list.size()));
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<Orgnization>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 根据ID删除该记录以及其子对象
	 */
	@RequestMapping(value = "/deleteWithChildById")
	@ResponseBody
	public Map<String, Object> deleteWithChildById(Orgnization entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		logger.info("根据ID删除该记录以及其子对象信息...");
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			beforDelete(entity, request);
			checkData(entity, request);
			if(!checkExistDataCache("base", session, entity)){
				throw new BasicServiceException("非法删除数据！");
			}
			orgnizationService.deleteWithChildById(entity);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value = "/run", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> run(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			CallParam callParam = new CallParam();
			callParam.setParam1(UserUtil.getUser(null).getCorpid());
			orgnizationService.getRunOrgUpdate(callParam);
			String returnStatus = callParam.getReturnStatus();
			boolean flag = "OK" == returnStatus ? true : false;
			result.put("success", true);
			result.put("result", callParam.getMsgData());
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value = "/companyList", method = RequestMethod.POST)
	@ResponseBody
	public List<Orgnization> companyList(QueryParams qps, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		List<Orgnization> list = null;
		qps.parseFromRaw();
		/*//按创建时间来排序
		Sorter sorter = new Sorter("created",Sorter.DIR_DESC);
		qps.addSorter(sorter);*/
		try{
			Orgnization t = (Orgnization)BasicModel.transformClass(Orgnization.class, qps);
			list = orgnizationService.queryCompanyInOrgnizationSelect(t);
		}catch(Exception e){
			e.printStackTrace();
		}
		return list;
	}

}
