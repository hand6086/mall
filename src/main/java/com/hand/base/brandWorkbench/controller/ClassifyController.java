package com.hand.base.brandWorkbench.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.controller.BasicControllerException;
import com.hand.base.basic.service.BasicService;
import com.hand.base.brandWorkbench.model.Classify;
import com.hand.base.brandWorkbench.service.ClassifyService;
import com.hand.core.basic.query.QueryParams;

@Controller
@RequestMapping("/action/portal/classify")
public class ClassifyController extends BasicController<Classify> {
	@Autowired
	private ClassifyService classifyService;
	
	@Override
	public BasicService<Classify> getBasicService() throws Exception {
		return classifyService;
	}
	
	/**
	 * 插入或更新前做操作
	 */
	public void beforBrandUpsert(Classify entity, HttpServletRequest request) throws Exception{
		entity.setPageFlag(false);
		if(classifyService.brandQueryByExamplePage(entity).size() > 0){
			throw new BasicControllerException("姓名不可重复！");
		}
	}
	
	@RequestMapping(value = "/classifyList")
	@ResponseBody
	public List<Classify> classifyList(QueryParams qps, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		List<Classify> list = null;
		Classify record = new Classify();
		try{
			record.setPageFlag(false);
			list = classifyService.queryByExamplePage(record);
		}catch(Exception e){
			e.printStackTrace();
		}
		return list;
	}
	
	@RequestMapping(value = "/brandClassifyList")
	@ResponseBody
	public List<Classify> brandClassifyList(QueryParams qps, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		List<Classify> list = null;
		Classify record = new Classify();
		try{
			record.setPageFlag(false);
			record.setNoName("首页");
			list = classifyService.queryByExamplePage(record);
		}catch(Exception e){
			e.printStackTrace();
		}
		return list;
	}
	
}
