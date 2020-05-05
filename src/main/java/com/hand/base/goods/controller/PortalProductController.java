package com.hand.base.goods.controller;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.controller.BasicControllerException;
import com.hand.base.basic.model.BasicModel;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.KeyGenerateService;
import com.hand.base.common.model.Image;
import com.hand.base.common.service.MyFileService;
import com.hand.base.goods.model.Goods;
import com.hand.base.goods.model.Product;
import com.hand.base.goods.model.ProductPack;
import com.hand.base.goods.service.ProductService;
import com.hand.core.basic.query.QueryParams;
import com.hand.core.util.FileUtil;
import com.hand.core.util.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/action/portal/product")
public class PortalProductController extends BasicController<Product> {
	private static final Logger logger = LogManager.getLogger(PortalProductController.class);
	@Autowired
	private ProductService productService;
	
	@Resource
	private MyFileService myFileService;
	
	@Resource
	private KeyGenerateService keyGenerateService;
	
	@Override
	public BasicService<Product> getBasicService() throws Exception {
		return productService;
	}


	@RequestMapping(value = "/list", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> list(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			Product record = new Product();

			String pageParam = request.getParameter("page");
			String rows = request.getParameter("rows");
			String provinceId = request.getParameter("provinceId");
			String cityId = request.getParameter("cityId");
			String districtId = request.getParameter("districtId");
			record.setProvinceId(provinceId);
			record.setCityId(cityId);
			record.setDistrictId(districtId);
			record.setRows(rows == null ? 10 : Integer.valueOf(rows));
			record.setPage(null == pageParam ? 1 : Integer.valueOf(pageParam));

			Integer total = productService.queryListCount(record);
			record.setTotal(total);

			String requestUrl = "/action/portal/product/list?";
			String requestAttr = "rows=" + record.getRows();
			if(!StringUtils.isNull(record.getCityId())) {
				requestAttr = requestAttr + "&cityId=" + record.getCityId();
			}
			if(!StringUtils.isNull(record.getDistrictId())) {
				requestAttr = requestAttr + "&districtId=" + record.getDistrictId();
			}

			String firstPageUrl = requestUrl + "page=1&" + requestAttr;
			String previousPageUrl;
			Integer page = record.getPage();
			if(1 == page) {
				previousPageUrl = requestUrl + "page=1&" + requestAttr;
			}else {
				previousPageUrl = requestUrl + "page=" + (page - 1) + "&" + requestAttr;
			}
			String nextPageUrl;
			Integer totalPage = record.getTotalPage();
			if(page == totalPage) {
				nextPageUrl = requestUrl + "page=" + totalPage + "&" + requestAttr;
			} else {
				nextPageUrl = requestUrl + "page=" + (page + 1) + "&" + requestAttr;
			}
			String lastPageUrl = requestUrl + "page=" + totalPage + "&" + requestAttr;

			ProductPack productPack = new ProductPack();
			productPack.setFirstPageUrl(firstPageUrl);
			productPack.setPreviousPageUrl(previousPageUrl);
			productPack.setNextPageUrl(nextPageUrl);
			productPack.setLastPageUrl(lastPageUrl);

			List<Product> list = productService.queryList(record);
			productPack.setRecords(list);
			result.put("success", 1);
			result.put("msg", "");
			result.put("data", productPack);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", 0);
			result.put("msg", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value = "/getNewId", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getNewId(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			String id = keyGenerateService.keyGenerate();
			result.put("success", true);
			result.put("id", id);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	//处理文件上传
    /*@RequestMapping(value="/uploadImg", method = RequestMethod.POST)
    public @ResponseBody String uploadImg(@RequestParam("myfiles") MultipartFile file,
            HttpServletRequest request) {
        String contentType = file.getContentType();
        String fileName = file.getOriginalFilename();
        System.out.println("fileName-->" + fileName);
        System.out.println("getContentType-->" + contentType);
        String filePath = request.getSession().getServletContext().getRealPath("imgupload/");
       
        return "uploadimg success";
    }*/

	@RequestMapping(value = "/uploadImg", method = RequestMethod.POST)
	@ResponseBody
	public void uploadImg(Goods record, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
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
			// goodsService.goodsShareUpdate(record, list);
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
	
	@RequestMapping(value = "/uploadImgUpdate", method = RequestMethod.POST)
	@ResponseBody
	public void uploadImgUpdate(Goods record, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
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
			// goodsService.goodsImageUpdate(record, list);
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
