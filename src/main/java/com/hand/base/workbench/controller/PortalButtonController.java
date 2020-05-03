package com.hand.base.workbench.controller;

import java.io.IOException;
import java.io.OutputStream;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.controller.BasicControllerException;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.common.model.Image;
import com.hand.base.common.service.MyFileService;
import com.hand.base.workbench.model.Button;
import com.hand.base.workbench.service.ButtonCityService;
import com.hand.base.workbench.service.ButtonService;
import com.hand.core.basic.query.QueryParams;
import com.hand.core.util.FileUtil;

@Controller
@RequestMapping("/action/portal/button")
public class PortalButtonController extends BasicController<Button> {
	@Autowired
	private ButtonService buttonService;
	
	@Autowired
	private ButtonCityService buttonCityService;
	
	@Resource
	private MyFileService myFileService;
	
	@Override
	public BasicService<Button> getBasicService() throws Exception {
		return buttonService;
	}
	
	@RequestMapping(value = "/uploadImg", method = RequestMethod.POST)
	@ResponseBody
	public void uploadImg(Button record, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request; 
		List<MultipartFile> myfiles=multipartRequest.getFiles("myfiles");
		if(!FileUtil.validateIsAllImage(myfiles)){
			throw new BasicControllerException("上上传图片格式错误！");
		}
		try{
			// 上传图片到服务器
			List<Image> list = myFileService.imgUpload(myfiles);
			// 将图片写到数据库
			buttonService.cityImageUpdate(record, list);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		
		try {
			ObjectMapper objectMapper = new ObjectMapper(); 
			OutputStream os;
    		response.setContentType("text/html;charset=UTF-8");  
			os = response.getOutputStream();
			JsonGenerator jsonGenerator = objectMapper.getFactory().createGenerator(os);
			jsonGenerator.writeObject(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value = "/uploadImg2", method = RequestMethod.POST)
	@ResponseBody
	public void uploadImg2(Button record, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request; 
		List<MultipartFile> myfiles=multipartRequest.getFiles("myfiles");
		if(!FileUtil.validateIsAllImage(myfiles)){
			throw new BasicControllerException("上上传图片格式错误！");
		}
		try{
			// 上传图片到服务器
			List<Image> list = myFileService.imgUpload(myfiles);
			// 将图片写到数据库
			buttonService.buttonImageUpdate(record, list);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		
		try {
			ObjectMapper objectMapper = new ObjectMapper(); 
			OutputStream os;
    		response.setContentType("text/html;charset=UTF-8");  
			os = response.getOutputStream();
			JsonGenerator jsonGenerator = objectMapper.getFactory().createGenerator(os);
			jsonGenerator.writeObject(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@Transactional
	public void beforDelete(Button entity, HttpServletRequest request) throws Exception{
		entity.setAttr5("headId");
		entity.setHeadId(entity.getId());
		buttonCityService.deleteById(entity);
	}
	
	@RequestMapping(value = "/buttonList")
	@ResponseBody
	public List<Button> buttonList(Button record,QueryParams qps, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		List<Button> list = null;
		try{
			record.setPageFlag(false);
			if("brand".equals(record.getSource())){
				list = buttonService.brandQueryByExamplePage(record);
			}else{
				list = buttonService.queryByExamplePage(record);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return list;
	}
	
	/**
	 * 新建或更新一条记录
	 */
	@RequestMapping(value = "/brandUpsert")
	@ResponseBody
	public Map<String, Object> brandUpsert(Button entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			checkData(entity, request);
			if(!getBasicService().isInsertFlag(entity) && !checkExistDataCache("base", session, entity)){
				throw new BasicServiceException("您操作太快了，请点击下方刷新按钮后再修改记录！");
			}
			buttonService.brandUpsert(entity);

			auditTrailInsert(entity,request,session,"US");    //审计追踪新建记录
		
			Button newEntry = buttonService.queryById(entity);
			result.put("newRow", newEntry);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
}
