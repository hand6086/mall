package com.hand.base.workbench.controller;

import java.io.IOException;
import java.io.OutputStream;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.common.base.Joiner;
import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.controller.BasicControllerException;
import com.hand.base.basic.model.BasicModel;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.common.model.Image;
import com.hand.base.common.service.MyFileService;
import com.hand.base.workbench.model.Campaign;
import com.hand.base.workbench.service.CampaignService;
import com.hand.core.basic.query.QueryParams;
import com.hand.core.util.FileUtil;

@Controller
@RequestMapping("/action/portal/campaign")
public class PortalCampaignController extends BasicController<Campaign> {
	@Autowired
	private CampaignService campaignService;
    
	@Resource
	private MyFileService myFileService;
	
	@Override
	public BasicService<Campaign> getBasicService() throws Exception {
		return campaignService;
	}
	
	public void beforUpsert(Campaign entity, HttpServletRequest request) throws Exception{
		if("Webpage Link".equals(entity.getShareType())&&
				("".equals(entity.getShareTheme())||"".equals(entity.getUrl())||"".equals(entity.getShareNotes()))){
			throw new BasicServiceException("网页分享时要加上分享的标题，url和分享的说明");
		}
	}
	
	@RequestMapping(value = "/uploadImg", method = RequestMethod.POST)
	@ResponseBody
	public void uploadImg(Campaign record, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
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
			campaignService.campImageUpdate(record, list);
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
	public void uploadImg2(Campaign record, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
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
			campaignService.lineImageUpdate(record, list);
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
	
	@RequestMapping(value = "/queryByConsDrawPage")
	@ResponseBody
	public Map<String, Object> queryByConsDrawPage(QueryParams qps,Campaign entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			qps.preDealSecurity(request);
			Campaign t = (Campaign)BasicModel.transformClass(entity, qps);
			beforQueryAllOrExample(t,request);
			beforQueryExample(t,request);
			List<Campaign> list = campaignService.queryByConsDrawPage(t);
			result.put("success", true);
			result.put("rows", list);
			this.pushCurrentDataCache(list, session.getId(), "base", false);
			result.put("total", getCount((BasicModel)t, list.size()));
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<Campaign>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 新建或更新一条记录
	 */
	@RequestMapping(value = "/brandUpsert")
	@ResponseBody
	public Map<String, Object> brandUpsert(Campaign entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			checkData(entity, request);
			if(!getBasicService().isInsertFlag(entity) && !checkExistDataCache("base", session, entity)){
				throw new BasicServiceException("您操作太快了，请点击下方刷新按钮后再修改记录！");
			}
			campaignService.brandUpsert(entity);

			auditTrailInsert(entity,request,session,"US");    //审计追踪新建记录
		
			Campaign newEntry = campaignService.queryById(entity);
			result.put("newRow", newEntry);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 新建或更新一条记录
	 */
	@RequestMapping(value = "/camsInsert")
	@ResponseBody
	@Transactional
	public Map<String, Object> camsInsert(Campaign entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			checkData(entity, request);

			String[] cityIds = entity.getAttr1().split(",");
			List<String> ids = new ArrayList<String>();
			for(int i = 0 ; i < cityIds.length ; i++){
				entity.setId(null);
				entity.setCityId(cityIds[i]);
				campaignService.insert(entity);
				auditTrailInsert(entity,request,session,"US");    //审计追踪新建记录
				ids.add(entity.getId());
			}
			
			String newRowIds = Joiner.on(",").join(ids);  
			
			result.put("newRowIds", newRowIds);
			result.put("newRowType", entity.getType());
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
}
