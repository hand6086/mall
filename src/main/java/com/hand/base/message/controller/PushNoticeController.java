package com.hand.base.message.controller;

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
import com.hand.base.message.model.PushNotice;
import com.hand.base.message.service.PushNoticeService;
import com.hand.base.user.model.User;
import com.hand.core.basic.query.QueryParams;
import com.hand.core.util.UserUtil;

@Controller
@RequestMapping("/action/portal/pushNotice")
public class PushNoticeController extends BasicController<PushNotice>{

	@Autowired
	private PushNoticeService pushNoticeService;
	
	public BasicService<PushNotice> getBasicService() throws Exception{
		if(pushNoticeService != null){
			return pushNoticeService;
		}
		throw new BasicControllerException("获取Basic Service 失败，请确认程序代码是否正确！");
	}
	
	public void beforQueryAllOrExample(PushNotice entity, HttpServletRequest request) throws Exception{
		User user = UserUtil.getUser(null);
		if(entity.getUserId() == null || "".equals(entity.getUserId())){
			String conditionSql = entity.getConditionSql();
			if(conditionSql == null){
				conditionSql = "";
			}
			entity.setConditionSql(conditionSql+" and userId="+"'"+user.getId()+"'");
		}
	}

	/**
	 * 
	 *<p>更新通知为已读</p>
	 * @author yrf
	 * @param pushNotice
	 * @return
	 */
	@RequestMapping("/read")
	@ResponseBody
	public Map<String, Object> updateRead(PushNotice pushNotice){
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			pushNoticeService.updateRead(pushNotice);
			result.put("success", true);
		}catch(Exception e){
			result.put("success", false);
			result.put("result", e.getLocalizedMessage());
		}
		return result;
	}
	
	/**
	 * 
	 *<p>更新所有通知为已读</p>
	 * @author yrf
	 * @param pushNotice
	 * @return
	 */
	@RequestMapping("/readAll")
	@ResponseBody
	public Map<String, Object> updateReadAll(PushNotice pushNotice){
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			pushNoticeService.updateReadAll(pushNotice);
			result.put("success", true);
		}catch(Exception e){
			result.put("success", false);
			result.put("result", e.getLocalizedMessage());
		}
		return result;
	}
	
	/**
	 * 根据条件查询待办事项记录,默认分页(若将'pageFlag'设置为'false'，则不分页)
	 */
	@RequestMapping(value = "/queryFlowPage")
	@ResponseBody
	public Map<String, Object> queryFlowPage(QueryParams qps, PushNotice entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<PushNotice>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 根据条件查询系统通知记录,默认分页(若将'pageFlag'设置为'false'，则不分页)
	 */
	@RequestMapping(value = "/queryPushNoticePage")
	@ResponseBody
	public Map<String, Object> queryPushNoticePage(QueryParams qps, PushNotice entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<PushNotice>());
			result.put("result", e.getMessage());
		}
		return result;
	}
}
