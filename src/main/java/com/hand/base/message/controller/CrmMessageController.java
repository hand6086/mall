package com.hand.base.message.controller;
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
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hand.base.message.model.CrmMessage;
import com.hand.base.message.model.UserMessage;
import com.hand.base.message.service.CrmMessageService;
import com.hand.base.user.model.User;
import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.model.BasicModel;
import com.hand.core.basic.query.QueryParams;
import com.hand.base.basic.service.BasicService;

@Controller
@RequestMapping("/action/portal/message")
public class CrmMessageController extends BasicController<CrmMessage> {
	private static final Logger logger = LogManager.getLogger(CrmMessageController.class);
	@Resource
	private CrmMessageService crmMessageService;

	@Override
	public BasicService<CrmMessage>  getBasicService() throws Exception{
		return crmMessageService;
	}
	
	/**
	 * 
	 *<p>新建或修改一条消息</p>
	 * @author lc
	 * @param msg
	 * @return
	 */
	@Override
	@RequestMapping("/upsert")
	@ResponseBody
	public Map<String, Object> upsert(CrmMessage msg, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response){
		logger.info("新建更新信息列表...");
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			crmMessageService.upsert(msg);
			CrmMessage newEntry = getBasicService().queryById(msg);
			result.put("newRow", newEntry);
			result.put("success", true);
		}catch(Exception e){
			result.put("success", false);
			result.put("result", e.getLocalizedMessage());
		}
		return result;
	}
	
	/**
	 * 基于消息插入更新之上的消息回复
	 * @author lc
	 * @param msg
	 * @return
	 */
	@RequestMapping("/messageReplyInsert")
	@ResponseBody
	public Map<String, Object> messageReplyInsert(CrmMessage msg){
		logger.info("回复信息列表...");
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			crmMessageService.messageReplyInsert(msg);
			result.put("success", true);
			
		}catch(Exception e){
			result.put("success", false);
			result.put("result", e.getLocalizedMessage());
		}
		return result;
	}
	
	/**
	 * 查询未在消息发送列表中的用户
	 * @param qps
	 * @return
	 */
	@RequestMapping(value = "/unSelectUserList")
	@ResponseBody
	public Map<String, Object> queryUnSelectUserListPage(HttpSession session,QueryParams qps,
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			User user =(User)session.getAttribute("UserContext");
			qps.setAttr2(user.getId());
			UserMessage t = (UserMessage)BasicModel.transformClass(UserMessage.class, qps);
			List<User> list = crmMessageService.queryUnSelectUserListPage(t);
			result.put("success", true);
			result.put("total", getCount(t, list.size()));
			result.put("rows", list);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	/**
	 * 保存@ 消息
	 * @param msgContent
	 * @return
	 */
	@RequestMapping("/atUserMsg")
	@ResponseBody
	@Transactional
	public Map<String, Object> atUserMsg(CrmMessage msg){
		logger.info("保存@消息...");
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			crmMessageService.atUserMsg(msg);
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
}
