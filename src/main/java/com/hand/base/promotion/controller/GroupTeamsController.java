package com.hand.base.promotion.controller;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.service.BasicService;
import com.hand.base.o2oaccnt.service.AreaManagerService;
import com.hand.base.promotion.model.GroupTeams;
import com.hand.base.promotion.service.GroupTeamsService;

/**
 * 拼团列表
 * 
 * @author guo
 *
 */
@Controller
@RequestMapping("/action/portal/groupTeams")
public class GroupTeamsController extends BasicController<GroupTeams> {
	@Autowired
	private GroupTeamsService groupTeamsService;
	
	@Resource
	private AreaManagerService areaManagerService;

	public BasicService<GroupTeams> getBasicService() throws Exception {
		return groupTeamsService;
	}
	
}
