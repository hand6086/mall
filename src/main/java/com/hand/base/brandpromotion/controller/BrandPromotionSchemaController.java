package com.hand.base.brandpromotion.controller;



import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.KeyGenerateService;
import com.hand.base.brandpromotion.model.BrandPromotionSchema;
import com.hand.base.brandpromotion.service.BrandPromotionSchemaService;
import com.hand.core.basic.query.QueryParams;

@Controller("BrandPromotionSchemaController")
@RequestMapping("/action/portal/brandPromotionSchema")
public class BrandPromotionSchemaController extends BasicController<BrandPromotionSchema>{
 
	@Resource
	private KeyGenerateService keyGenerateService;

	@Resource
	private BrandPromotionSchemaService brandPromotionSchemaService;

	@Override
	public BasicService<BrandPromotionSchema> getBasicService() throws Exception {
		return brandPromotionSchemaService;
	}	 
	
	@RequestMapping(value = "/query")
	public String query(QueryParams qps,BrandPromotionSchema entity, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		List<BrandPromotionSchema> list = null;
		try{
			list = brandPromotionSchemaService.queryByExamplePage(entity);
			session.setAttribute("result", list);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "brandPromotion/brandSeckillApplyList";
	}
}
