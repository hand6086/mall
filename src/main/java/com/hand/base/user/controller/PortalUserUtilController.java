package com.hand.base.user.controller;

import java.util.HashMap;
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

import com.hand.base.basic.controller.BasicControllerException;
import com.hand.base.user.model.User;
import com.hand.base.user.model.UserChange;
import com.hand.base.user.service.UserService;
import com.hand.core.util.Constants;
import com.hand.core.util.UserUtil;

@Controller
@RequestMapping("/action/portal/userUtil")
public class PortalUserUtilController {
	
	private static final Logger logger = LogManager.getLogger(PortalUserUtilController.class);
	
	@Resource
	private UserService userService;
	
	
	@RequestMapping(value = "/changePassword", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object>  changePassword(UserChange userChange,HttpSession session, HttpServletRequest request,HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		User user = UserUtil.getUser(session);
		try{
			if(userChange != null){
				logger.debug(Constants.LOG_DIVISION_LINE + "modify password start！");
				userService.modifyPassword(user, userChange.getOldPassword(), userChange.getNewPassword(), userChange.getConfirmPassword());
				logger.debug(Constants.LOG_DIVISION_LINE + "modify password end！");
			}else{
				logger.debug(Constants.LOG_DIVISION_LINE + "the info of password is null！");
				throw new BasicControllerException("密码信息为空");
			}
			result.put("success", true);
		}catch(Exception e){
			logger.debug(Constants.LOG_DIVISION_LINE + e.getMessage());
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value = "/changeEmployeePassword", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object>  changeEmployeePassword(UserChange userChange,HttpSession session, HttpServletRequest request,HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			if(userChange != null){
				logger.debug(userChange.getId()+"+"+userChange.getNewPassword()+"+"+userChange.getConfirmPassword());
				logger.debug(Constants.LOG_DIVISION_LINE + "modify password start！");
				userService.modifyEmpLoyeePassword(userChange.getId(),userChange.getEmpType(), userChange.getNewPassword(), userChange.getConfirmPassword());
				logger.debug(Constants.LOG_DIVISION_LINE + "modify password end！");
			}else{
				logger.debug(Constants.LOG_DIVISION_LINE + "the info of password is null！");
				throw new BasicControllerException("密码信息为空");
			}
			result.put("success", true);
		}catch(Exception e){
			logger.debug(Constants.LOG_DIVISION_LINE + e.getMessage());
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
}
