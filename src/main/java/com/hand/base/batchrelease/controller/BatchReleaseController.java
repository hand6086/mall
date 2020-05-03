package com.hand.base.batchrelease.controller;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.model.CallParam;
import com.hand.base.basic.service.BasicService;
import com.hand.base.batchrelease.model.BatchRelease;
import com.hand.base.batchrelease.service.BatchReleaseService;
import com.hand.base.user.model.User;
import com.hand.core.util.UserUtil;
@Controller
@RequestMapping("/action/portal/batchrelease")
public class BatchReleaseController  extends BasicController<BatchRelease>  {
	@Autowired
	private BatchReleaseService batchReleaseService;
	
	public BasicService<BatchRelease> getBasicService() throws Exception{
		return batchReleaseService;
	}
	
	
	public void beforQueryAllOrExample(BatchRelease entity, HttpServletRequest request) throws Exception{
		User user = UserUtil.getUser(null);
		if(user != null){
			entity.setCreatedBy(user.getId());
		}
	}
	
	@RequestMapping(value = "/check", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> check(CallParam callParam, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			batchReleaseService.runCouponCheck(callParam);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 导入校验成功的优惠券数据
	 * @param callParam
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/runCouponImport", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> runCouponImport(CallParam callParam, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			batchReleaseService.runCouponImport(callParam);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 删除多条记录
	 */
	@RequestMapping(value = "/allDelete")
	@ResponseBody
	public Map<String, Object> allDelete(HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			batchReleaseService.allDelete();
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
}
