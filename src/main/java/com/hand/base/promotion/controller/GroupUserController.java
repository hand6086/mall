package com.hand.base.promotion.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.service.BasicService;
import com.hand.base.promotion.model.GroupUser;
import com.hand.base.promotion.service.GroupUserService;

/**
 * 拼团人员
 * 
 * @author guo
 *
 */
@Controller
@RequestMapping("/action/portal/groupUser")
public class GroupUserController extends BasicController<GroupUser> {
	@Autowired
	private GroupUserService groupUserService;

	public BasicService<GroupUser> getBasicService() throws Exception {
		return groupUserService;
	}

}
