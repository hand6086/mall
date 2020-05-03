package com.hand.base.message.controller;

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
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hand.base.common.model.InterObject;
import com.hand.base.message.model.UserMessage;
import com.hand.base.message.service.UserMessageService;
import com.hand.base.user.model.User;
import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.controller.BasicControllerException;
import com.hand.base.basic.model.BasicModel;
import com.hand.core.basic.query.Filter;
import com.hand.core.basic.query.QueryParams;
import com.hand.base.basic.service.BasicService;
import com.hand.core.util.StringUtils;

/**
 * 
 * <p>用户-消息Controller</p>
 * <p>Description</p>
 * <p>Company</p>
 * @author yrf
 * @date 2016年7月5日  上午9:43:56
 */
@Controller
@RequestMapping("/action/portal/userMessage")
public class UserMessageController extends BasicController<UserMessage> {

	private static final Logger logger = LogManager.getLogger(UserMessageController.class);
	@Resource
	private UserMessageService userMessageService;
	
	@Override
	public BasicService<UserMessage>  getBasicService() throws Exception{
		return userMessageService;
	}
	/**
	 * 
	 *<p>查询当前登录用户消息</p>
	 * @author yrf
	 * @param qps
	 * @param session
	 * @return
	 */
	@RequestMapping("/queryMyMessagePage")
	@ResponseBody
	public Map<String, Object> queryMyMessagePage(QueryParams qps, HttpSession session){
		logger.info("分页查询当前登录用户消息...");
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			User user =(User)session.getAttribute("UserContext");
			Filter filter = new Filter("isSend", "Y");
			qps.setAttr1(user.getId());
			qps.addFilter(filter);
			qps.setPageFlag(false);
			UserMessage record = (UserMessage)BasicModel.transformClass(UserMessage.class, qps);
			List<UserMessage> list = userMessageService.queryMyMessagePage(record);
			result.put("success", true);
			result.put("total", getCount(record, list.size()));
			result.put("rows", list);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<UserMessage>());
			result.put("result", e.getLocalizedMessage());
		}
		return result;
	}
	
	/**
	 * 添加用户到消息发送列表
	 * @param list
	 * @param qps
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/addUserOfMessage", method = RequestMethod.POST)
	@ResponseBody
	@Transactional
	public Map<String, Object> addUserOfMessage(@RequestBody List<InterObject> list, QueryParams qps, HttpSession session, HttpServletRequest request,HttpServletResponse response){
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			for(int i=0; list != null && i<list.size(); i++){
				InterObject record = list.get(i);
				UserMessage userMsg = new UserMessage();
				userMsg.setMsgId(record.getPreObjId());
				userMsg.setUserId(record.getRearObjId());
				userMessageService.insert(userMsg);
			}
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 
	 *<p>设置消息为已读</p>
	 * @author yrf
	 * @param userMsg
	 * @return
	 */
	@RequestMapping(value = "/updateReadFlag", method = RequestMethod.POST)
	@ResponseBody
	@Transactional
	public Map<String, Object> updateReadFlag(String ids){
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			if(StringUtils.isNull(ids)){
				throw new BasicControllerException("请选择至少一条消息");
			}
			
			String[] idArray = ids.split(",");
			UserMessage userMsg = new UserMessage();
			userMsg.setIds(idArray);
			userMessageService.readFlagUpdate(userMsg);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
}
