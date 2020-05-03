package com.hand.base.o2oaccnt.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hand.base.o2oaccnt.model.StoreRegister;
import com.hand.base.o2oaccnt.service.StoreRegisterService;
import com.hand.base.user.model.User;
import com.hand.core.util.PasswordUtil;
import com.hand.core.util.UserUtil;

@Controller()
@RequestMapping("/action/portal/storeregister")
public class StoreRegisterController {
	public static String username = "username";
	public static String password = "password";
	public static String phonenumber = "phonenumber";

	@Resource
	private StoreRegisterService sRegisterService;
	
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> register(StoreRegister record, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		String username = request.getParameter("username");
		String phonenumber = request.getParameter("phonenumber");
		String password = request.getParameter("password");

		record.setUsername(username);
		record.setPassword(PasswordUtil.generatePwd(password));
		record.setPhonenumber(phonenumber);
		try {
			List<StoreRegister> user = sRegisterService.getUserByName(record);
			//判断用户名是否已存在
			if(user.size()>0){
				result.put("success", false);
				result.put("result", "该用户名已存在！");
				return result;
			}
			sRegisterService.register(record);
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			// result.put("rows", new ArrayList<StoreRegister>());
			result.put("result", e.getMessage());
		}

		return result;
	}
	
	@RequestMapping(value = "/isregistered", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> isregistered(StoreRegister record, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		String phone = request.getParameter("contactPhone");
		record.setPhonenumber(phone);
		try{
			List<StoreRegister> register=sRegisterService.getUserByPhone(record);
			int size = register.size();
			if(size > 0){
				String userid = register.get(0).getId();
				String username = register.get(0).getUsername();
				result.put("size", size);
				result.put("userid", userid);
				result.put("username", username);
				result.put("success", false);
				result.put("result", "该号码已注册！");
				return result;
			}
			result.put("success", true);

		}catch(Exception e){
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	/**
	 * 根据商户当前状态修改为下一状态
	 * @param record
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	
	
	@RequestMapping(value = "/storeStatusUpdate", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> storeStatusUpdate(StoreRegister record, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			String storeStatus = request.getParameter("storeStatus");
			if(storeStatus != null && !"".equals(storeStatus)){
				record.setStoreStatus("cancel");
			}
			sRegisterService.storeStatusUpdate(record);
			result.put("success", true);
			result.put("result", "状态修改成功");
		}catch(Exception e){
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	/**
	 * 根据用户名查询用户信息
	 * @param record
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getUserByName", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getUserByName(StoreRegister record, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			User user= UserUtil.getUser(null);
			record.setUsername(user.getUsername());
			List<StoreRegister> list=sRegisterService.getUserByName(record);
			result.put("success", true);
			result.put("result", list.get(0));
		}catch(Exception e){
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
}
