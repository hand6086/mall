package com.hand.base.user.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.model.BasicModel;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.KeyGenerateService;
import com.hand.base.user.model.AppUser;
import com.hand.base.user.model.User;
import com.hand.base.user.service.AppUserService;
import com.hand.core.basic.query.QueryParams;

@Controller
@RequestMapping("/action/portal/appuser")
public class PortalAppUserController extends BasicController<AppUser>{
	
	private static final Logger logger = LogManager.getLogger(PortalAppUserController.class);
	
	@Resource
	private AppUserService appuserService;
	@Resource
	private KeyGenerateService keyGenerateService;
	
	public BasicService<AppUser> getBasicService(){
		return appuserService;
	}
	
	@RequestMapping(value = "/queryByExamplePage")
	@ResponseBody
	public Map<String, Object> queryByExamplePage(QueryParams qps, AppUser entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			qps.preDealSecurity(request);
			AppUser t = (AppUser)BasicModel.transformClass(entity, qps);
			beforQueryAllOrExample(t,request);
			beforQueryExample(t,request);
			List<AppUser> list = new ArrayList<AppUser>();
			if(qps.getOnlyCountFlag()){
				result.put("success", true);
				int count = appuserService.queryAppUserCount(t);
				AppUser appuser = new AppUser();
				appuser.setTotal(count);
				list.add(appuser);
				result.put("rows", list);
			}else{
				list = appuserService.queryByExamplePage(t);
				result.put("success", true);
				result.put("rows", list);
				this.pushCurrentDataCache(list, session.getId(), "base", false);
				result.put("total", getCount((BasicModel)t, list.size()));
			}
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<User>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 重置app用户登录错误次数
	 * @param record
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/resetErrorTimes", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> resetErrorTimes(AppUser appUser, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		LoginController loginController = new LoginController();
		try{
			loginController.resetAppLoginErrorTimes(appUser.getPhoneNumber());
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
}
