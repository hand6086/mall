package com.hand.base.mvg.controller;


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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hand.base.mvg.model.Mvg;
import com.hand.base.mvg.service.MvgService;
import com.hand.base.user.model.User;
import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.model.BasicModel;
import com.hand.core.basic.query.QueryParams;
import com.hand.core.util.UserUtil;


@Controller
@RequestMapping("/action/portal/mvg")
public class PortalMvgController{
	
	private static final Logger logger = LogManager.getLogger(PortalMvgController.class);

	@Resource
	private MvgService mvgService;
	
	@RequestMapping(value = "/queryLeftListPage")
	@ResponseBody
	public Map<String, Object> queryLeftListPage(QueryParams qps, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			qps.preDealSecurity(request);
			User user = UserUtil.getUser(session);
			qps.setUserOrgId(user.getOrgId());
			qps.setUserPositionId(user.getPostnId());
			mvgService.setMvgMapperName(qps.getMvgMapperName());
			BasicModel t = (BasicModel)BasicModel.transformClass(Class.forName(mvgService.getBeanName(qps.getMvgMapperName())), qps);
			List<HashMap<String, String>> list = mvgService.queryLeftListPage(t);
			result.put("success", true);
			result.put("rows", list);
			result.put("total", BasicController.getCount(t, list.size()));
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<Mvg>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value = "/queryRightListPage")
	@ResponseBody
	public Map<String, Object> queryRightListPage(QueryParams qps, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			qps.preDealSecurity(request);
			User user = UserUtil.getUser(session);
			qps.setUserOrgId(user.getOrgId());
			qps.setUserPositionId(user.getPostnId());
			mvgService.setMvgMapperName(qps.getMvgMapperName());
			BasicModel t = (BasicModel) BasicModel.transformClass(Class.forName(mvgService.getBeanName(qps.getMvgMapperName())), qps);
			List<HashMap<String, String>> list = mvgService.queryRightListPage(t);
			result.put("success", true);
			result.put("rows", list);
			result.put("total", BasicController.getCount(t, list.size()));
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<Mvg>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value = "/batchInsert")
	@ResponseBody
	public Map<String, Object> batchInsert(@RequestBody List<Mvg> list, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			String defMvgStId = null;//默认子ID
			if(list != null && list.size() > 0){
				mvgService.setMvgMapperName(list.get(0).getMvgMapperName());
				defMvgStId = mvgService.batchInsert(list);
			}
			result.put("defMvgStId", defMvgStId);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value = "/insert")
	@ResponseBody
	public Map<String, Object> create(Mvg entity, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			mvgService.setMvgMapperName(entity.getMvgMapperName());
			mvgService.insert(entity);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value = "/batchDelete")
	@ResponseBody
	public Map<String, Object> batchDelete(@RequestBody List<Mvg> list, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			String defMvgStId = null;//默认子ID
			if(list != null && list.size() > 0){
				mvgService.setMvgMapperName(list.get(0).getMvgMapperName());
				defMvgStId = mvgService.batchDeleteById(list);
			}
			result.put("defMvgStId", defMvgStId);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value = "/deleteAll")
	@ResponseBody
	public Map<String, Object> deleteAll(Mvg entity, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			mvgService.setMvgMapperName(entity.getMvgMapperName());
			mvgService.deleteAllById(entity);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value = "/delete")
	@ResponseBody
	public Map<String, Object> delete(Mvg entity, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		logger.info("删除一条列表信息...");
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			mvgService.setMvgMapperName(entity.getMvgMapperName());
			mvgService.deleteById(entity);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
//	/**
//	 * 根据名称获取bean的url
//	 * @param qps
//	 * @return
//	 * @throws Exception
//	 */
//	private String getBeanName(QueryParams qps) throws Exception {
//		String beanUrl = "";//查询参数(JavaBean)的全称
//		String mvgMapperName = qps.getMvgMapperName();//启用的mapper名称
//		if(StringUtils.isBlank(mvgMapperName)){
//			throw new BasicControllerException("mvgMapperName名称不能为空，请检查程序！");
//		}
//		if(!mvgMapperName.contains("Mapper")){
//			mvgMapperName = mvgMapperName + "MvgMapper";
//		}
//		String beanName = mvgMapperName.replace("Mapper", "Bean");
//		Field beanField = new MvgMapperBeen().getClass().getField(beanName);//根据名称获取bean的url
//		beanUrl = beanField.getType().toString().replace("class ", "");//获取javaBean的名称
//		return beanUrl;
//	}
}
