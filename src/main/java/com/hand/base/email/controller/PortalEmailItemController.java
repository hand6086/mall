package com.hand.base.email.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hand.base.email.model.EmailItem;
import com.hand.base.email.service.EmailItemService;
import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.model.BasicModel;
import com.hand.core.basic.query.Filter;
import com.hand.core.basic.query.QueryParams;
import com.hand.base.basic.service.BasicService;


@Controller
@RequestMapping("/action/portal/emailItem")
public class PortalEmailItemController extends BasicController<EmailItem>{

	@Resource
	private EmailItemService emailItemService;
	
	@Override
	public BasicService<EmailItem>  getBasicService() throws Exception{
		return emailItemService;
	}

	/**
	 * 预处理：存在父子级联，所以强制父Id不能为空
	 */
	@Override
	public void beforQueryAllOrExample(EmailItem entity, HttpServletRequest request) throws Exception{
		QueryParams qps = new QueryParams();
		qps.invokePreFilterAndSorter();
		List<Filter> filterList = qps.getFilterByProperty("emailId");
		if(filterList == null || filterList.size() == 0){
			qps.addFilter(new Filter("emailId","noMatchId"));
		}
		entity = (EmailItem)BasicModel.transformClass(EmailItem.class, qps);
	}
	
}
