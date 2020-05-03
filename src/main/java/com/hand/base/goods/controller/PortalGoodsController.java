package com.hand.base.goods.controller;

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

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
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
import com.hand.base.basic.model.BasicModel;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.basic.service.KeyGenerateService;
import com.hand.base.common.controller.PortalFilesController;
import com.hand.base.common.model.Image;
import com.hand.base.common.service.MyFileService;
import com.hand.base.goods.model.Goods;
import com.hand.base.goods.service.GoodsService;
import com.hand.base.user.model.User;
import com.hand.core.basic.query.QueryParams;
import com.hand.core.util.FileUtil;
import com.hand.core.util.StringUtils;
import com.hand.core.util.UserUtil;

@Controller
@RequestMapping("/action/portal/goods")
public class PortalGoodsController extends BasicController<Goods> {
	private static final Logger logger = LogManager.getLogger(PortalGoodsController.class);
	@Autowired
	private GoodsService goodsService;
	
	@Resource
	private MyFileService myFileService;
	
	@Resource
	private KeyGenerateService keyGenerateService;
	
	@Override
	public BasicService<Goods> getBasicService() throws Exception {
		return goodsService;
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
			goodsService.goodsShareUpdate(record, list);
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
			goodsService.goodsImageUpdate(record, list);
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
    
	@RequestMapping(value = "/queryProdPicklist")
	@ResponseBody
	public Map<String, Object> queryProdPicklist(QueryParams qps,Goods entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			qps.preDealSecurity(request);
			Goods t = (Goods)BasicModel.transformClass(entity, qps);
			beforQueryAllOrExample(t,request);
			beforQueryExample(t,request);
			List<Goods> list = goodsService.queryProdCodeByPage(t);
			result.put("success", true);
			result.put("rows", list);
			this.pushCurrentDataCache(list, session.getId(), "base", false);
			result.put("total", getCount((BasicModel)t, list.size()));
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<Goods>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 查询 单位字段 下拉列表
	 * @param qps
	 * @return
	 */
	@RequestMapping(value = "/queryUnit")
	@ResponseBody
	public List<Goods> queryUnit(QueryParams qps,Goods entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		List<Goods> list = null;
		try{
			Goods t = (Goods)BasicModel.transformClass(entity, qps);
			list = goodsService.queryUnit(t);
		}catch(Exception e){
			e.printStackTrace();
		}
		return list;
	}

	@RequestMapping(value = "/queryDetailById")
	@ResponseBody
	public Map<String, Object> queryDetailById(Goods entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			Goods record = goodsService.queryDetailById(entity);
			List<Goods> list = new ArrayList<Goods>();
			list.add(record);
			this.pushCurrentDataCache(list, session.getId(), "base", false);
			result.put("result", record);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 更新商品form表单 详情 
	 * @param entity
	 * @throws Exception
	 */
	@RequestMapping(value = "/detailUpdate")
	@ResponseBody
	public Map<String, Object> detailUpdate(Goods entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			goodsService.detailUpdate(entity);	
			auditTrailInsert(entity,request,session,"U");    //审计追踪新建记录
			
			Goods record = goodsService.queryDetailById(entity);
			result.put("newRow", record);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 更改产品系列字段为“产品组合”，更改套装商品Flag=Y
	 * @param entity
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveAsSuitGoods")
	@ResponseBody
	public Map<String, Object> saveAsSuitGoods(Goods entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			goodsService.saveAsSuitGoods(entity);	
			auditTrailInsert(entity,request,session,"U");    //审计追踪新建记录
			
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
	@RequestMapping(value = "/batchAproveUpsert", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> batchAproveUpsert(Goods entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			String ids = entity.getId();
			String[] idArray = ids.split(",");
			for(String str : idArray){
				if(!StringUtils.isNull(str)){
					entity.setId(str);
					getBasicService().brandUpsert(entity);
				}
			}
			auditTrailInsert(entity,request,session,"US");    //审计追踪新建记录
		
			Goods newEntry = getBasicService().queryById(entity);
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
