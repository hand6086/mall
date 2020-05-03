package com.hand.base.o2odataimport.controller;

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
import com.hand.base.basic.model.CallParam;
import com.hand.base.basic.service.BasicService;
import com.hand.base.common.model.Image;
import com.hand.base.common.service.MyFileService;
import com.hand.base.o2odataimport.model.RestaurantTemp;
import com.hand.base.o2odataimport.service.RestaurantImpService;
import com.hand.base.user.model.User;
import com.hand.base.workbench.model.SmsSend;
import com.hand.core.util.FileUtil;
import com.hand.core.util.HttpUtils;
import com.hand.core.util.UserUtil;
@Controller
@RequestMapping("/action/portal/restaurantTemp")
public class RestaurantTempController  extends BasicController<RestaurantTemp>{
	private static final Logger logger = LogManager.getLogger(RestaurantTempController.class);
	
	@Resource
	private RestaurantImpService restaurantImpService;
	
	@Resource
	private MyFileService myFileService;
	
	public BasicService<RestaurantTemp> getBasicService(){
		return restaurantImpService;
	}
	
	public void beforQueryExample(RestaurantTemp entity, HttpServletRequest request) throws Exception{
		User user = UserUtil.getUser(null);
		entity.setCreatedBy(user.getId());
	}
	
	@RequestMapping(value = "/uploadImg", method = RequestMethod.POST)
	@ResponseBody
	public void uploadImg(RestaurantTemp record, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
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
			record.setLogo(list.get(0).getId());
			restaurantImpService.update(record);
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
	
	@RequestMapping(value = "/check", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> check(CallParam callParam, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			restaurantImpService.runRestaurantCheck(callParam);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value = "/restaurantImpInsert", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> restaurantImpInsert(CallParam callParam, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			restaurantImpService.runRestaurantImp(callParam);
			
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value = "/updateLatLng", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateLatLng(RestaurantTemp entity, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			User user = UserUtil.getUser(null);
			entity.setCreatedBy(user.getId());
			entity.setAttr5("updateLatLng");
			entity.setPageFlag(false);
			List<RestaurantTemp> list = restaurantImpService.queryByExamplePage(entity);
			
			for(RestaurantTemp restaurantTemp : list){
				String logistics = restaurantTemp.getProvince()+restaurantTemp.getCity()+restaurantTemp.getDistrict()+restaurantTemp.getStreet()+restaurantTemp.getAddress();
				Map<String, Double> map = HttpUtils.getLngAndLat(logistics);
				Double longtitude = map.get("longtitude");
				Double latitude = map.get("latitude");
				restaurantTemp.setLongtitude(longtitude);
				restaurantTemp.setLatitude(latitude);
				restaurantImpService.update(restaurantTemp);
			}
			
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
}
