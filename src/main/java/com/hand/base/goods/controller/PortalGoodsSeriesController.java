package com.hand.base.goods.controller;

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
import com.hand.base.common.service.MyFileService;
import com.hand.base.goods.model.GoodsSeries;
import com.hand.base.goods.service.GoodsSeriesService;
import com.hand.core.basic.query.QueryParams;
import com.hand.core.util.FileUtil;

@Controller
@RequestMapping("/action/portal/goodsSeries")
public class PortalGoodsSeriesController extends BasicController<GoodsSeries> {
	@Autowired
	private GoodsSeriesService goodsSeriesService;
	
	@Resource
	private MyFileService myFileService;
	
	@Override
	public BasicService<GoodsSeries> getBasicService() throws Exception {
		return goodsSeriesService;
	}
	
	@RequestMapping(value = "/uploadImg", method = RequestMethod.POST)
	@ResponseBody
	public void uploadImg(GoodsSeries record, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
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
			goodsSeriesService.goodsSeriesImageUpate(record, list);
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
	
	@RequestMapping(value = "/queryByPkAll")
	@ResponseBody
	public List<GoodsSeries> queryByPkAll(QueryParams qps,GoodsSeries entity, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		List<GoodsSeries> list = null;
		try{
			list = goodsSeriesService.queryByPkAll(entity);
		}catch(Exception e){
			e.printStackTrace();
		}
		return list;
	}

}
