package com.hand.base.o2oaccnt.controller;

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
import com.hand.base.basic.model.BasicModel;
import com.hand.base.basic.service.BasicService;
import com.hand.base.common.model.Image;
import com.hand.base.o2oaccnt.model.Area;
import com.hand.base.o2oaccnt.service.AreaService;
import com.hand.core.basic.query.QueryParams;
import com.hand.core.util.FileUtil;

@Controller()
@RequestMapping("/action/portal/area")
public class AreaController extends BasicController<Area> {
	@Resource
	private AreaService areaService;

	@Override
	public BasicService<Area> getBasicService() {
		return areaService;
	}
	
	
	@RequestMapping(value = "/parentAreaPickListPage", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> parentAreaPickList(Area record, QueryParams qps, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			Area t = (Area)BasicModel.transformClass(record, qps);
			List<Area> list = areaService.parentAreaPickListPage(t);
			t.preDealSecurity(request);
			result.put("success", true);
			result.put("rows", list);
			result.put("total", getCount(((BasicModel) t), list.size()));
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<Area>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	@RequestMapping(value = "/actualCityPickListPage", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> actualCityPickList(Area record, QueryParams qps, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			Area t = (Area)BasicModel.transformClass(record, qps);
			List<Area> list = areaService.actualCityPickListPage(t);
			t.preDealSecurity(request);
			result.put("success", true);
			result.put("rows", list);
			result.put("total", getCount(((BasicModel) t), list.size()));
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<Area>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value = "/uploadImg", method = RequestMethod.POST)
	@ResponseBody
	public void uploadImg(Area record, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request; 
		List<MultipartFile> myfiles=multipartRequest.getFiles("myfiles");
		if(!FileUtil.validateIsAllImage(myfiles)){
			throw new BasicControllerException("上上传图片格式错误！");
		}
		try{
			// 上传图片到服务器
			List<Image> list = areaService.imgUpload(myfiles);
			// 将图片写到数据库
			areaService.areaImageUpate(record, list);
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
}
