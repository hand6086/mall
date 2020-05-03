package com.hand.base.tablemanage.controller;

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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.controller.BasicControllerException;
import com.hand.base.basic.model.BasicModel;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.basic.service.KeyGenerateService;
import com.hand.base.platformfavorable.model.Platformfavorable;
import com.hand.base.platformfavorable.service.PlatformfavorableService;
import com.hand.base.tablemanage.model.tableManage;
import com.hand.base.tablemanage.service.tableManageService;
import com.hand.base.user.model.User;
import com.hand.core.basic.query.QueryParams;
import com.hand.core.util.UserUtil;
@Controller
@RequestMapping("/action/portal/tablemanage")
public class tableManageController extends BasicController<tableManage> {
	private static final Logger logger = LogManager.getLogger(BasicController.class);
	@Autowired
	private tableManageService tablemanageService;
	@Resource
	private KeyGenerateService keyGenerateService;
	public BasicService<tableManage> getBasicService() throws Exception{
		if(tablemanageService != null){
			return tablemanageService;
		}
		throw new BasicControllerException("获取Basic Service 失败，请确认程序代码是否正确！");
	}
	
	
	
@RequestMapping("/queryFieldPage")
	@ResponseBody
	public Map<String, Object> queryActivity(QueryParams qps, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			qps.preDealSecurity(request);
			
			tableManage t = (tableManage)BasicModel.transformClass(tableManage.class, qps);
			beforQueryAllOrExample(t,request);
			beforQueryExample(t,request);
			
			List<tableManage> list = tablemanageService.queryFieldPage(t);
			result.put("success", true);
			result.put("rows", list);
			this.pushCurrentDataCache(list, session.getId(), "base", false);
			result.put("total", getCount((BasicModel)t, list.size()));
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<Platformfavorable>());
			result.put("result", e.getMessage());
		}
		return result;
	}

@RequestMapping(value = "/filedInsert")
@ResponseBody
public Map<String, Object> filedInsert(tableManage entity, HttpSession session, 
		HttpServletRequest request, HttpServletResponse response) {
	Map<String, Object> result = new HashMap<String, Object>();
	try{
		beforInsert(entity, request);
		beforUpsert(entity, request);
		entity.setId(keyGenerateService.keyGenerate());
		tablemanageService.filedInsert(entity);		
		
		auditTrailInsert(entity,request,session,"N");    //审计追踪新建记录
		
		tableManage newEntry = getBasicService().queryById(entity);
		result.put("newRow", newEntry);
		result.put("success", true);
	}catch(Exception e){
		e.printStackTrace();
		result.put("success", false);
		result.put("result", e.getMessage());
	}
	return result;
}
@RequestMapping(value = "/filedupdate")
@ResponseBody
public Map<String, Object> filedupdate(tableManage entity, HttpSession session, 
		HttpServletRequest request, HttpServletResponse response) {
	Map<String, Object> result = new HashMap<String, Object>();
	try{
		beforInsert(entity, request);
		beforUpsert(entity, request);
		
		tablemanageService.filedupdate(entity);		
		
		auditTrailInsert(entity,request,session,"N");    //审计追踪新建记录
		
		tableManage newEntry = getBasicService().queryById(entity);
		result.put("newRow", newEntry);
		result.put("success", true);
	}catch(Exception e){
		e.printStackTrace();
		result.put("success", false);
		result.put("result", e.getMessage());
	}
	return result;
}
@RequestMapping(value = "/deleteById")
@ResponseBody
public Map<String, Object> deleteById(tableManage entity, HttpSession session, 
		HttpServletRequest request, HttpServletResponse response) {
	logger.info("删除一条列表信息...");
	Map<String, Object> result = new HashMap<String, Object>();
	try{
		beforDelete(entity, request);
		checkData(entity, request);
		if(!checkExistDataCache("base", session, entity)){
			throw new BasicServiceException("非法删除数据！");
		}
		
		auditTrailInsert(entity,request,session,"D");    //审计追踪新建记录
		tablemanageService.deleteById(entity);
		tablemanageService.deletefiledId(entity);
		result.put("success", true);
	}catch(Exception e){
		e.printStackTrace();
		result.put("success", false);
		result.put("result", e.getMessage());
	}
	return result;
}
@RequestMapping(value = "/deletefiledId")
@ResponseBody
public Map<String, Object> deletefiledId(tableManage entity, HttpSession session, 
		HttpServletRequest request, HttpServletResponse response) {
	logger.info("删除一条列表信息...");
	Map<String, Object> result = new HashMap<String, Object>();
	try{
		beforDelete(entity, request);
		checkData(entity, request);
		if(!checkExistDataCache("base", session, entity)){
			throw new BasicServiceException("非法删除数据！");
		}
		
		auditTrailInsert(entity,request,session,"D");    //审计追踪新建记录
		tablemanageService.deletefiledId(entity);
		result.put("success", true);
	}catch(Exception e){
		e.printStackTrace();
		result.put("success", false);
		result.put("result", e.getMessage());
	}
	return result;
}


	

	
}
