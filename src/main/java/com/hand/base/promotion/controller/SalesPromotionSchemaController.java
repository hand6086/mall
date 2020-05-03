package com.hand.base.promotion.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.util.Date;
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
import com.hand.base.o2oaccnt.service.AreaManagerService;
import com.hand.base.promotion.model.Promotion;
import com.hand.base.promotion.model.SalesPromotionSchema;
import com.hand.base.promotion.service.PromotionService;
import com.hand.base.promotion.service.SalesPromotionSchemaService;
import com.hand.core.basic.query.QueryParams;
import com.hand.core.util.DateUtil;
import com.hand.core.util.FileUtil;

@Controller
@RequestMapping("/action/portal/salesPromotionSchema")
public class SalesPromotionSchemaController extends BasicController<SalesPromotionSchema> {
	@Autowired
	private SalesPromotionSchemaService salesPromotionSchemaService;

	@Resource
	private AreaManagerService areaManagerService;
	
	@Resource
	private MyFileService myFileService;
	
	@Resource
	private PromotionService promotionService;

	public BasicService<SalesPromotionSchema> getBasicService() throws Exception {
		return salesPromotionSchemaService;
	}

	/**
	 * 设置组织ID安全性
	 */
//	@Override
//	public void beforQueryExample(SalesPromotionSchema entity, HttpServletRequest request) throws Exception {
//		User user = UserUtil.getUser(null);
//		// 获取当前登录人的组织ID
//		AreaManager areaManager = new AreaManager();
//		areaManager.setOrgId(user.getOrgId());
//		// 根据组织ID查询对应城市ID、需先设置page 否则limit从-1开始
//		areaManager.setPage(1);
//		List<AreaManager> areaManagerlist = areaManagerService.queryByExamplePage(areaManager);
//		if (areaManagerlist != null && areaManagerlist.size() > 0) {
//			areaManager = areaManagerlist.get(0);
//			// 将得到的当前用户组织ID对应的城市ID赋给活动对象的orgId字段，使之后的查询根据该城市ID进行筛选
//			entity.setOrgId(areaManager.getId());
//		}
//	};

	public void beforUpsert(SalesPromotionSchema entity, HttpServletRequest request) {

		Date startDate = DateUtil.getDateFormat(entity.getStartDate(), "yyyy-MM-dd HH:mm:ss");
		Date endDate = DateUtil.getDateFormat(entity.getEndDate(), "yyyy-MM-dd HH:mm:ss");

		if (startDate != null && !"".equals(startDate) && endDate != null && !"".equals(endDate)) {
			if (startDate.after(endDate)) {
				throw new BasicControllerException("开始时间不能晚于结束时间");
			}
		} else{
			throw new BasicControllerException("活动时间不能为空");
		}
	}
	public void beforBrandUpsert(SalesPromotionSchema entity, HttpServletRequest request) {
		
		//活动开始时间
		Date startDate = DateUtil.getDateFormat(entity.getStartDate(), "yyyy-MM-dd HH:mm:ss");
		//活动结束时间
		Date endDate = DateUtil.getDateFormat(entity.getEndDate(), "yyyy-MM-dd HH:mm:ss");
		//报名开始时间
		Date tattr13 = DateUtil.getDateFormat(entity.getTattr13(), "yyyy-MM-dd HH:mm:ss");
		//报名结束时间
		Date tattr14 = DateUtil.getDateFormat(entity.getTattr14(), "yyyy-MM-dd HH:mm:ss");
		
		if (startDate != null && !"".equals(startDate) && endDate != null && !"".equals(endDate)
				&& tattr13 != null && !"".equals(tattr13) && tattr14 != null && !"".equals(tattr14)) {
			if (tattr13.after(tattr14)) {
				throw new BasicControllerException("报名开始时间不能晚于报名结束时间");
			}
			if (startDate.after(endDate)) {
				throw new BasicControllerException("活动开始时间不能晚于活动结束时间");
			}
			if (tattr14.after(startDate)) {
				throw new BasicControllerException("报名结束时间不能晚于活动开始时间");
			}
		} else{
			throw new BasicControllerException("时间不能为空");
		}
	}
	
	@RequestMapping(value = "/uploadImg", method = RequestMethod.POST)
	@ResponseBody
	public void uploadImg(SalesPromotionSchema record, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
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
			if(list != null && list.size() > 0){
				record.setPicId(list.get(0).getId());
				salesPromotionSchemaService.brandUpdate(record);
			}
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
	@RequestMapping(value = "/queryApplyList")
	public String queryApplyList(QueryParams qps,SalesPromotionSchema entity, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		List<SalesPromotionSchema> list = null;
		try{
			// 参数brandStatus为空则活动报名需要字段（中文），不为空为英文 （页面搜索栏查询使用）
			list = salesPromotionSchemaService.brandQueryByExamplePage(entity);
			session.setAttribute("result", list);
		}catch(Exception e){
			e.printStackTrace();
		}
		if("FightGroup".equals(entity.getType())){
			return "brandPromotion/brandGroupApplyList";
		}
		return "brandPromotion/brandSeckillApplyList";
	}
	/**
	 * 促销管理-品牌馆删除促销方案时修改活动状态到无效
	 */
	@RequestMapping(value="/updateStatusOnDelete",method=RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> updateStatusOnDelete(SalesPromotionSchema entity, HttpServletRequest request){
		Map<String, Object> result = new HashMap<String,Object>();
		Promotion promotion = new Promotion();
		promotion.setSchemaId(entity.getId());
		promotion.setPageFlag(false);
		List<Promotion> protionList = null;
		try {
			protionList = promotionService.brandQueryByExamplePage(promotion);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("result", e.getMessage());
			e.printStackTrace();
		}
		for(Promotion promotionItem : protionList) {
			promotionItem.setStatus("Inactive");
			try {
				result.put("success", true);
				promotionService.batchUpdateStatus(promotionItem);
			} catch (Exception e) {
				result.put("success", false);
				result.put("result", e.getMessage());
				e.printStackTrace();
			}
		}
		return result;
	}
}
