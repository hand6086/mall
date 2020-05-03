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
import com.hand.base.basic.controller.BasicControllerException;
import com.hand.base.basic.model.BasicModel;
import com.hand.base.basic.service.BasicService;
import com.hand.base.workbench.model.CamPic;
import com.hand.base.workbench.model.Campaign;
import com.hand.base.workbench.service.CamPicService;
import com.hand.core.basic.query.QueryParams;

@Controller
@RequestMapping("/action/portal/camPic")
public class PortalCamPicController extends BasicController<CamPic> {
	@Autowired
	private CamPicService camPicService;
    
	@Override
	public BasicService<CamPic> getBasicService() throws Exception {
		return camPicService;
	}
	
	public void beforQueryExample(CamPic entity, HttpServletRequest request) throws Exception{
		entity.setOauth("");
	}
	
	@Override
	public void beforUpsert(CamPic entity, HttpServletRequest request) throws Exception {
		if( "Second Kill".equals(entity.getLineType()) ){
			// 根据行记录id查询不为该id下的数据量（头id一致）
			int activityNum = camPicService.queryActivityCount(entity);
			if (activityNum != 0) {
				throw new BasicControllerException("同一个城市,同时间段内只能有一个有效的秒杀活动");
			}
		}
	}
}
