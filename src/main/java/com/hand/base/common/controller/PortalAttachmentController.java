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
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.controller.BasicControllerException;
import com.hand.base.basic.model.BasicModel;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.basic.service.KeyGenerateService;
import com.hand.base.common.model.Attachment;
import com.hand.base.common.service.AttachmentService;
import com.hand.core.basic.query.QueryParams;
import com.hand.core.util.AppConstants;
import com.hand.core.util.FileUtil;
import com.hand.core.util.StringUtils;

@Controller
@RequestMapping("/portal/attachment")
public class PortalAttachmentController extends BasicController<Attachment> {

	private static final Logger logger = LogManager.getLogger(PortalAttachmentController.class);

	@Resource
	private AttachmentService attachmentService;

	@Resource
	private KeyGenerateService keyGenerateService;

	@Override
	public BasicService<Attachment> getBasicService() throws Exception {
		return attachmentService;
	}

	@Override
	@Transactional
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insert(Attachment entity, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		MultipartFile myfile = multipartRequest.getFile("uploadAttachment");
		try {
			if (StringUtils.isBlank(entity.getHeadId())) {
				throw new BasicServiceException("headId不能为空。");
			}
			if (myfile == null) {
				throw new BasicServiceException("附件不能为空。");
			}
			if (StringUtils.isBlank(entity.getModuleType())) {
				throw new BasicServiceException("业务模块不能为空。");
			}
			// 插入附件表
			logger.info("上传附件记录！");
			attachmentService.upload(myfile, entity);// 附件上传
			logger.info("插入附件记录！");
			attachmentService.insert(entity);// 向附件表插入附件基础信息
			Attachment newEntry = attachmentService.queryById(entity);
			result.put("success", true);
			result.put("newRow", newEntry);
			result.put("entity", entity);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}

	/**
	 * 多附件上传
	 * 
	 * @param entity
	 *            附件entity
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@Transactional
	@RequestMapping(value = "/insertWithFiles", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> createAttachments(Attachment entity, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		List<MultipartFile> myfiles = multipartRequest.getFiles("uploadAttachment");
		if(!FileUtil.validateIsAllImage(myfiles)){
			throw new BasicControllerException("上上传图片格式错误！");
		}
		try {
			if (StringUtils.isBlank(entity.getHeadId())) {
				throw new BasicServiceException("headId不能为空。");
			}
			if (myfiles.size() == 0) {
				throw new BasicServiceException("附件不能为空。");
			}
			if (StringUtils.isBlank(entity.getModuleType())) {
				throw new BasicServiceException("业务模块不能为空。");
			}
			// 插入附件表
			logger.info("上传附件记录！");
			logger.info("插入附件记录！");
			for (MultipartFile file : myfiles) {
				entity.setId(keyGenerateService.keyGenerate());
				attachmentService.upload(file, entity);// 上传附件
				attachmentService.insert(entity);// 向附件表插入附件基础信息
			}
			result.put("success", true);
			result.put("entity", entity);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}

	/**
	 * 查询资料库列表
	 */
	@RequestMapping(value = "/queryLibrary")
	@ResponseBody
	public Map<String, Object> queryLibrary(QueryParams qps, Attachment entity, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			Attachment t = (Attachment) BasicModel.transformClass(Attachment.class, qps);
			List<Attachment> list = attachmentService.queryAttachmentLibraryListPage(t);
			result.put("success", true);
			result.put("rows", list);
			result.put("total", getCount(t, list.size()));
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<Attachment>());
			result.put("result", e.getMessage());
		}
		return result;
	}

	@RequestMapping(value = "/downloadPath", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> downloadPath(QueryParams qps, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			if (StringUtils.isNull(qps.getId())) {
				throw new BasicServiceException("ID不能为空！");
			}
			Attachment entity = new Attachment();
			entity.setId(qps.getId());
			List<Attachment> list = attachmentService.queryByExamplePage(entity);
			if (list.size() != 1) {
				throw new BasicServiceException("找不到附件");
			}
			Attachment attachment = list.get(0);
			String fileUrl = AppConstants.portalShareUrlDir + attachment.getAttachmentPath() + "/"
					+ attachment.getAttachmentName();
			result.put("url", fileUrl);
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}

	@Override
	public void beforQueryAllOrExample(Attachment entity, HttpServletRequest request) throws Exception {
		if (StringUtils.isBlank(entity.getHeadId())) {
			if (StringUtils.isNotBlank(entity.getId())) {
				entity.setHeadId(entity.getId());
				entity.setId("");// 将ID置空
			} else if (StringUtils.isNotBlank(request.getParameter("headId"))) {
				entity.setHeadId(request.getParameter("headId"));
			} else {
				entity.setHeadId("noMatchId");
			}
		}
	}

	/**
	 * 
	 * <p>
	 * 批量下载文件
	 * </p>
	 * 
	 * @author yrf
	 * @param ids
	 * @return
	 */
	@RequestMapping(value = "/downloadBatch")
	@ResponseBody
	public Map<String, Object> downloadBatch(String ids) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			if (StringUtils.isBlank(ids)) {
				result.put("success", false);
				result.put("result", "请选中需要下载的文件");
			}
			String[] id = ids.split(",");
			String fileUrl = attachmentService.batchDownload(id);
			result.put("success", true);
			result.put("url", fileUrl);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
}
