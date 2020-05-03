package com.hand.base.goods.controller;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.model.BasicModel;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.KeyGenerateService;
import com.hand.base.common.service.MyFileService;
import com.hand.base.goods.model.Category;
import com.hand.base.goods.model.GoodsSeriesCity;
import com.hand.base.goods.service.CategoryService;
import com.hand.core.basic.query.QueryParams;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/action/portal/category")
public class PortalCategoryController extends BasicController<Category> {
	private static final Logger logger = LogManager.getLogger(PortalCategoryController.class);
	@Autowired
	private CategoryService categoryService;
	
	@Resource
	private MyFileService myFileService;
	
	@Resource
	private KeyGenerateService keyGenerateService;
	
	@Override
	public BasicService<Category> getBasicService() throws Exception {
		return categoryService;
	}

	@RequestMapping(value = "/queryAllCategory")
	@ResponseBody
	public Map<String, Object> queryAllCategory(QueryParams qps, Category entity, HttpSession session,
												 HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			qps.preDealSecurity(request);
			Category t = (Category) BasicModel.transformClass(entity, qps);
			beforQueryAllOrExample(t,request);
			beforQueryExample(t,request);
			List<Category> list = categoryService.queryAllCategory();
			result.put("success", true);
			result.put("rows", list);
			result.put("total", getCount((BasicModel)t, list.size()));
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<GoodsSeriesCity>());
			result.put("result", e.getMessage());
		}
		return result;
	}
}
