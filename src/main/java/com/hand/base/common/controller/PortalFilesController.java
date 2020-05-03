package com.hand.base.common.controller;

import java.io.IOException;
import java.io.OutputStream;
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
import com.hand.base.common.model.Image;
import com.hand.base.common.model.MyFile;
import com.hand.base.common.service.MyFileService;
import com.hand.core.util.AppConstants;
import com.hand.core.util.FileUtil;

@Controller
@RequestMapping("/action/portal/myFile")
public class PortalFilesController extends BasicController<MyFile>{
	
	private static final Logger logger = LogManager.getLogger(PortalFilesController.class);
	
	@Resource
	private MyFileService myFileService;
	
	
	@Override
	public BasicService<MyFile> getBasicService() throws Exception {
		return myFileService;
	}
	
	/**
	 * 上传图片到服务器
	 * @param record
	 * @param session
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/uploadImg", method = RequestMethod.POST)
	@ResponseBody
	public void uploadImg(MyFile record, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request; 
		List<MultipartFile> myfiles=multipartRequest.getFiles("file");
		if(!FileUtil.validateIsAllImage(myfiles)){
			throw new BasicControllerException("上上传图片格式错误！");
		}
		try{
			// 上传图片到服务器,并将图片写入到数据库
			logger.info("upload image start------------------------------");
			logger.info(myfiles);
			List<Image> list = myFileService.imgUpload(myfiles);
			logger.info(list);
			logger.info("upload image end------------------------------");
			
			for(Image image : list){
				image.setThumbUrl(AppConstants.portalSharePicHttpDir + image.getThumbUrl());
			}
			
			
			result.put("result", list.get(0));
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("message", e.getMessage());
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
	
}
