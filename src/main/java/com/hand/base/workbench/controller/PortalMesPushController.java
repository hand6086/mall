package com.hand.base.workbench.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.model.BasicModel;
import com.hand.base.basic.service.BasicService;
import com.hand.base.workbench.model.Campaign;
import com.hand.base.workbench.model.MesPush;
import com.hand.base.workbench.service.MesPushService;
import com.hand.core.basic.query.QueryParams;

@Controller
@RequestMapping("/action/portal/mesPush")
public class PortalMesPushController extends BasicController<MesPush> {
	@Autowired
	private MesPushService mesPushService;
    
	@Override
	public BasicService<MesPush> getBasicService() throws Exception {
		return mesPushService;
	}
	
	@RequestMapping(value = "/queryByAllCityPage")
	@ResponseBody
	public Map<String, Object> queryBySecKillPage(QueryParams qps,MesPush entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			qps.preDealSecurity(request);
			MesPush t = (MesPush)BasicModel.transformClass(entity, qps);
			beforQueryAllOrExample(t,request);
			beforQueryExample(t,request);
			List<MesPush> list = mesPushService.queryByAllCityPage(t);
			result.put("success", true);
			result.put("rows", list);
			this.pushCurrentDataCache(list, session.getId(), "base", false);
			result.put("total", getCount((BasicModel)t, list.size()));
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<Campaign>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	
}
