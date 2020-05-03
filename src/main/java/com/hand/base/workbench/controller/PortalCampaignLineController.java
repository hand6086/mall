package com.hand.base.workbench.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.service.BasicService;
import com.hand.base.workbench.model.Campaign;
import com.hand.base.workbench.service.CampaignLineService;

@Controller
@RequestMapping("/action/portal/campaignLine")
public class PortalCampaignLineController extends BasicController<Campaign> {
	@Autowired
	private CampaignLineService campaignLineService;
    
	@Override
	public BasicService<Campaign> getBasicService() throws Exception {
		return campaignLineService;
	}
	
	public void beforQueryExample(Campaign entity, HttpServletRequest request) throws Exception{
		entity.setOauth("");
	}

	/**
	 * 新建或更新一条记录
	 */
	@RequestMapping(value = "/camLinesInsert")
	@ResponseBody
	@Transactional
	public Map<String, Object> camLinesInsert(Campaign entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			checkData(entity, request);

			String[] camIds = entity.getAttr1().split(",");
			for(int i = 0 ; i < camIds.length ; i++){
				entity.setId(null);
				entity.setCamId(camIds[i]);
				campaignLineService.insert(entity);
				auditTrailInsert(entity,request,session,"US");    //审计追踪新建记录
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
