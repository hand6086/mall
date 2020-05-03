package com.hand.base.common.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.common.model.Attachment;
import com.hand.base.common.model.ScrollImg;
import com.hand.base.common.service.AttachmentService;
import com.hand.base.common.service.ScrollImgService;
import com.hand.core.util.StringUtils;

@Controller("ScrollImgController")
@RequestMapping("/portal/scrollImg")
public class ScrollImgController extends BasicController<ScrollImg> {
	
	private static final Logger logger = LogManager.getLogger(ScrollImgController.class);

	@Resource
	private AttachmentService attachmentService;

	@Resource
	private ScrollImgService scrollImgService;

	@Override
	public BasicService<ScrollImg> getBasicService() throws Exception {
		return scrollImgService;
	}
	
	@Override
	public void beforQueryAllOrExample(ScrollImg entity, HttpServletRequest request) throws Exception {
		super.beforQueryAllOrExample(entity, request);
		String appType = request.getParameter("appType");
		String activeFlag = request.getParameter("activeFlag");
		if(StringUtils.isNotBlank(appType)){
			entity.setAppType(appType);
		}
		if(StringUtils.isNotBlank(activeFlag)){
			if(entity.getConditionSql() == null){
				entity.setConditionSql("");
			}
			entity.setConditionSql(entity.getConditionSql()+" and activeFlag="+"'"+activeFlag+"'");
		}
		if(StringUtils.isBlank(entity.getAppType())){
			throw new BasicServiceException("系统类型不能为空。");
		}
		
	}
	
	/**
	 * 更新产品图片
	 */
	@RequestMapping(value = "/imgIdUpdate")
	@Transactional
	@ResponseBody
	public Map<String, Object> imgIdUpdate(ScrollImg entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		MultipartFile myfile = multipartRequest.getFile("myfile");
		try{
			if(!checkExistDataCache("base", session, entity)){
				throw new BasicServiceException("非法更新数据！");
			}
			if (myfile == null) {
				throw new BasicServiceException("附件不能为空。");
			}
			ScrollImg oldEntry = scrollImgService.queryById(entity);
			if(oldEntry == null){
				throw new BasicServiceException("根据ID不能找到附件。");
			}
			try {
				String oldImgId = oldEntry.getImgId();
				if(StringUtils.isNotBlank(oldImgId)){
					attachmentService.deleteById(oldImgId);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			// 插入附件表
			Attachment imgObj = new Attachment();
			imgObj.setHeadId(entity.getId());
			imgObj.setModuleType("HomeScrollImages");
			logger.info("上传附件记录！");
			attachmentService.upload(myfile, imgObj);// 附件上传
			logger.info("插入附件记录！");
			attachmentService.insert(imgObj);// 向附件表插入附件基础信息
			entity.setImgId(imgObj.getId());
			scrollImgService.imgIdUpdate(entity);
			auditTrailInsert(entity,request,session,"U");    //审计追踪新建记录
			ScrollImg newEntry = scrollImgService.queryById(entity);
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
