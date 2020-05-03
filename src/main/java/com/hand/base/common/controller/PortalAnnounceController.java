package com.hand.base.common.controller;

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

import com.hand.base.user.model.User;
import com.hand.core.util.*;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.controller.BasicControllerException;
import com.hand.base.basic.model.BasicModel;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.basic.service.KeyGenerateService;
import com.hand.base.common.model.Announce;
import com.hand.base.common.model.Attachment;
import com.hand.base.common.model.InterObject;
import com.hand.base.common.service.AnnounceService;
import com.hand.base.common.service.AttachmentService;
import com.hand.base.common.service.InterObjectService;
import com.hand.base.orgnization.model.Orgnization;
import com.hand.core.basic.query.Filter;
import com.hand.core.basic.query.QueryParams;
import com.hand.core.basic.query.Sorter;
import com.hand.core.modules.export.ExportFactory;
import com.hand.core.modules.export.ExportWriter;

@Controller
@RequestMapping("/action/portal/announce")
public class PortalAnnounceController extends BasicController<Announce>{
	
	private static final Logger logger = LogManager.getLogger(PortalAnnounceController.class);
	
	@Resource
	private AnnounceService announceService;
	
	@Resource
	private AttachmentService attachmentService;
	
	@Resource
	private KeyGenerateService keyGenerateService;
	
	@Resource
	private InterObjectService interObjectService;
	
	@Override
	public BasicService<Announce> getBasicService() throws Exception {
		return announceService;
	}
	
	/**
	 * 跳转到 公告管理 列表界面
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/manageInit")
	public String manageInit( HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		logger.debug(Constants.LOG_DIVISION_LINE + "the list of manage annouce init!");
		return "announce/AnnounceManage";
	}
	
	@RequestMapping(value = "/newInit")
	public String newInit( HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		String announceId = keyGenerateService.keyGenerate();
		Announce record = new Announce();
		record.setId(announceId);
		logger.debug(Constants.LOG_DIVISION_LINE + "annouce insert start!");
		try {
			announceService.announceInsert(record);
		} catch (BasicServiceException e) {
			e.printStackTrace();
		}
		logger.debug(Constants.LOG_DIVISION_LINE + "annouce insert end!");
		request.setAttribute("announceId", announceId);
		return "announce/AnnounceNew";
	}
	
	@RequestMapping(value = "/anneOrgMvgInit/{id}")
	public String anneOrgMvgInit(@PathVariable String id,  HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("id", id);
		logger.debug(Constants.LOG_DIVISION_LINE + "organization mvg for announce init: anneId is:" + id);
		return "mvg/AnnounceOrgMvg";
	}
	
	@RequestMapping(value = "/anneOrgReadOnlyMvgInit/{id}")
	public String anneOrgReadOnlyMvgInit(@PathVariable String id,  HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("id", id);
		logger.debug(Constants.LOG_DIVISION_LINE + "organization mvg(ReadOnly) for announce init: anneId is:" + id);
		return "mvg/AnnounceOrgReadOnlyMvg";
	}

	@RequestMapping(value = "/manageList")
	@ResponseBody
	public Map<String, Object> manageList(QueryParams qps, Announce entity,HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Announce> list = new ArrayList<Announce>();
		qps.addSorter(new Sorter("lastUpdated",Sorter.DIR_DESC));
		try{
			qps.preDealSecurity(request);
			Announce t = (Announce)BasicModel.transformClass(entity.getClass(), qps);
			beforQueryAllOrExample(t,request);
			beforQueryExample(t,request);
			t.setAnneStatus(entity.getAnneStatus());
			t.setAttr1(entity.getAttr1());
			list = announceService.queryByExamplePage(t);
			result.put("success", true);
			result.put("rows", list);
			this.pushCurrentDataCache(list, session.getId(), "base", false);
			result.put("total", getCount(((BasicModel)t), list.size()));
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<Announce>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	/**
	 * 导出
	 */
	@Override
	@RequestMapping(value = "/manageList/exportData")
	@ResponseBody
	public Map<String, Object> exportData(Announce entity, QueryParams qps, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		logger.info("导出列表...");
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			qps.preDealSecurity(request);
			ExportWriter exportWriter = ExportFactory.newInstance(qps);
			Announce t = (Announce)BasicModel.transformClass(entity.getClass(), qps);
			List<Announce> list = announceService.queryByExamplePage(t);
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
	
	/**
	 * 品牌馆 发布公告
	 */
	@RequestMapping(value = "/brandPublish")
	@ResponseBody
	public Map<String, Object> publish(Announce entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			announceService.publishAnnounceUpdate(entity);	
			Announce newEntry = announceService.queryById(entity);
			result.put("newRow", newEntry);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value = "/publish", method = RequestMethod.POST)
	@ResponseBody
	public void updateRole(Announce record, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request; 
		List<MultipartFile> myfiles=multipartRequest.getFiles("myfiles");

		if(!FileUtil.validateIsAllImage(myfiles)){
			throw new BasicControllerException("上上传图片格式错误！");
		}
		String announceId = record.getId();
		try{
			// 插入附件表
			// 生成附件Id
			logger.debug(Constants.LOG_DIVISION_LINE + "attachment insert start!");
			List<Attachment> list = attachmentService.attachmentListUpload(myfiles);// 附件上传，返回一个附件对象的列表
			for(Attachment attachment : list)
			{
				String attachmentId = keyGenerateService.keyGenerate();
				
				attachment.setId(attachmentId);
				attachment.setAnnouncementId(announceId);
				attachment.setComments("--");
				attachmentService.insert(attachment);//向附件表插入附件基础信息
				InterObject interObject=new InterObject();
				String id = keyGenerateService.keyGenerate();
				interObject.setId(id);
				interObject.setPreObjId(announceId);
				interObject.setRearObjId(attachmentId);
				interObjectService.announceAttachInsert(interObject);//向公告附件表插入基础信息
			}
			logger.debug(Constants.LOG_DIVISION_LINE + "attachment insert end!");
			
			// 发布公告
			logger.debug(Constants.LOG_DIVISION_LINE + "annouce publish start!");
			announceService.publishAnnounceUpdate(record);
			logger.debug(Constants.LOG_DIVISION_LINE + "annouce publish end!");
			
			result.put("success", true);
			result.put("result", "公告：" + record.getCaptions() + "，发布成功！");
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

	@RequestMapping(value = "/edit/{id}")
	public String edit(@PathVariable String id, QueryParams qps,HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		if(StringUtils.isBlank(id)){
			throw new BasicServiceException("ID不能为空！");
		}
		Announce result = null;
		List<Attachment> list = null;
		try{
			Announce entity = new Announce();
			entity.setId(id);
			result = announceService.brandQueryById(entity);
			if(result == null){
				throw new BasicServiceException("未查找到对应公告记录！");
			}
			list = attachmentService.queryAttachmentListByAnnounceId(entity);
			for(Attachment attachment : list){
				String fileUrl = AppConstants.portalShareUrlDir + attachment.getAttachmentPath() + "/" + attachment.getAttachmentName();
				attachment.setAttr1(fileUrl);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		request.setAttribute("result", result);
		request.setAttribute("list", list);
		return "announce/AnnouceInfo";
	}

	/**
	 * 查询一条记录
	 */
	@RequestMapping(value = "/editQueryById")
	@ResponseBody
	public Map<String, Object> editQueryById(Announce entity, HttpSession session,
										 HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		User user = UserUtil.getUser(session);
		try{
			Announce record = announceService.queryById(entity);
			List<Attachment> attachmentList = attachmentService.queryAttachmentListByAnnounceId(entity);
			for(Attachment attachment : attachmentList){
				String fileUrl = AppConstants.portalShareUrlDir + attachment.getAttachmentPath() + "/" + attachment.getAttachmentName();
				attachment.setAttr1(fileUrl);
			}
			List<Announce> list = new ArrayList<Announce>();
			list.add(record);
			this.pushCurrentDataCache(list, session.getId(), "base", false);
			result.put("result", record);
			result.put("list", attachmentList);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}

	@RequestMapping(value = "/downloadFile/{id}")
	public void downloadFile(@PathVariable("id") String id, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		if(!StringUtils.isNull(id))
		{
			try {
				QueryParams qps = new QueryParams();
				qps.setId(id);
				qps.addFilter(new Filter("id", qps.getId()));
				Attachment record = new Attachment();
				record.setId(id);
				Attachment rs =  attachmentService.queryById(record);
				//List<Attachment> list = attachmentService.queryListSelect(qps);
				/*if(list.size() != 1){
					throw new BasicServiceException("找不到附件");
				}
				Attachment rs = list.get(0);*/
				if(rs == null){
					throw new BasicServiceException("找不到附件");
				}
				
				FileUtil.downloadFile(rs, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	@RequestMapping(value = "/announceDelete/{id}", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> announceDelete(@PathVariable("id") String id,HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		Announce record=new Announce();
		record.setId(id);
		try{
			announceService.deleteById(record);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value = "/delAttach/{id}")
	@ResponseBody
	public Map<String, Object> deleteAnnounceFile(@PathVariable String id,HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			Attachment record = new Attachment();
			record.setId(id);
			// 删除附件表、删除中间表、删除服务器上的文件
			attachmentService.deleteAttachmentInAnnounceId(record);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}

	@RequestMapping(value = "/announceInsert", method = RequestMethod.POST)
	@ResponseBody
	public void announceInsert(Announce record, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		String announceId = record.getId();
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		List<MultipartFile> myfiles=multipartRequest.getFiles("myfiles");
		try{
			// 插入附件表
			// 生成附件Id
			logger.debug("attachment insert start!");
			List<Attachment> list = attachmentService.attachmentListUpload(myfiles);// 附件上传，返回一个附件对象的列表
			for(Attachment attachment : list)
			{
				String attachmentId = keyGenerateService.keyGenerate();
				attachment.setId(attachmentId);
				attachment.setAnnouncementId(announceId);
				attachment.setComments("--");
				attachmentService.insert(attachment);//向附件表插入附件基础信息

				InterObject interObject = new InterObject();
				String id = keyGenerateService.keyGenerate();
				interObject.setId(id);
				interObject.setPreObjId(announceId);
				interObject.setRearObjId(attachmentId);
				interObjectService.announceAttachInsert(interObject);//向公告附件表插入基础信息
			}
			logger.debug("attachment insert end!");

			// 修改公告表
			logger.debug("update announce start!");
			announceService.insert(record);
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
	
	@RequestMapping(value = "/announceUpdate", method = RequestMethod.POST)
	@ResponseBody
	public void announceUpdate(Announce record, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		String announceId = record.getId();
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request; 
		List<MultipartFile> myfiles=multipartRequest.getFiles("myfiles");
		try{
			// 插入附件表
			// 生成附件Id
				logger.debug("attachment insert start!");
				List<Attachment> list = attachmentService.attachmentListUpload(myfiles);// 附件上传，返回一个附件对象的列表
				for(Attachment attachment : list)
				{
					String attachmentId = keyGenerateService.keyGenerate();
					attachment.setId(attachmentId);
					attachment.setAnnouncementId(announceId);
					attachment.setComments("--");
					attachmentService.insert(attachment);//向附件表插入附件基础信息
					
					InterObject interObject = new InterObject();
					String id = keyGenerateService.keyGenerate();
					interObject.setId(id);
					interObject.setPreObjId(announceId);
					interObject.setRearObjId(attachmentId);
					interObjectService.announceAttachInsert(interObject);//向公告附件表插入基础信息
				}
				logger.debug("attachment insert end!");
						
				// 修改公告表
				logger.debug("update announce start!");
				announceService.update(record);
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
	
	/* ******************公告-营销渠道（组织）中间表操作    start   ********************** */
	@RequestMapping(value = "/unSelectedOrgList")
	@ResponseBody
	public Map<String, Object> unSelectedOrgList(QueryParams qps, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Orgnization> list = null;
		qps.addSorter(new Sorter("created",Sorter.DIR_DESC));
		logger.debug(Constants.LOG_DIVISION_LINE + "organization mvg for announce invoke: anneId is:" + qps.getId());
		try{
			list = announceService.queryUnSelectedOrgListPage(qps);
			result.put("success", true);
			result.put("rows", list);
			result.put("total", qps.getTotal());
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value = "/selectedOrgList")
	@ResponseBody
	public Map<String, Object> selectedOrgList(QueryParams qps, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Orgnization> list = null;
		qps.addSorter(new Sorter("created",Sorter.DIR_DESC));
		logger.debug(Constants.LOG_DIVISION_LINE + "organization mvg for announce invoke: anneId is:" + qps.getId());
		try{
			list = announceService.querySelectedOrgListPage(qps);
			result.put("success", true);
			result.put("rows", list);
			result.put("total", qps.getTotal());
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value = "/orgOfAnnounceInsert", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> orgOfAnnounceInsert(InterObject record, HttpSession session, HttpServletRequest request,HttpServletResponse response){
		Map<String, Object> result = new HashMap<String, Object>();
		Announce announce = new Announce();
		announce.setId(record.getPreObjId());
		announce.setOrgId(record.getRearObjId());
		logger.debug(Constants.LOG_DIVISION_LINE + "organization of announce insert start: announceId is: " + record.getPreObjId());
		logger.debug(Constants.LOG_DIVISION_LINE + "organization of announce insert start: organizationId is: " + record.getRearObjId());
		try{
			announceService.orgOfAnnounceInsert(announce);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		logger.debug(Constants.LOG_DIVISION_LINE + "organization of announce insert end!");
		return result;
	}
	
	@RequestMapping(value = "/orgOfAnnounceDel", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> orgOfAnnounceDel(Announce record, HttpSession session, HttpServletRequest request,HttpServletResponse response){
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			announceService.orgOfAnnounceDel(record);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	/* ******************公告-营销渠道（组织）中间表操作      end  ********************** */
}
