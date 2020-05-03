package com.hand.base.user.controller;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.service.BasicService;
import com.hand.base.user.model.OnlineUser;
import com.hand.base.user.service.OnlineUserService;
import com.hand.base.user.service.OnlineUserTaskServiceImpl;

@Controller
@RequestMapping("/action/portal/online")
public class PortalOnlineUserController extends BasicController<OnlineUser>{
	private static final Logger logger = LogManager.getLogger(PortalOnlineUserController.class);
	@Resource
	private OnlineUserService onlineUserService;
	
	
	@Resource
	private OnlineUserTaskServiceImpl onlineUserTaskService;
	
	@Override
	public BasicService<OnlineUser>  getBasicService() throws Exception{
		return onlineUserService;
	}
	
    /**
     * 一)功能：修复数据。
     * 二)原因：由于服务器非正常方式关闭会导致在线用户表不能及时删除数据，导致数据冗余。
     * 三)实现原理：通过遍历匹配服务器上的sessionId和在线用户表的sessionId字段，找出在线用户表的冗余记录，并且删除
     */
    @RequestMapping(value = "/dataRecovery")
	@ResponseBody
	public Map<String, Object> dataRecovery(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		return onlineUserTaskService.dataRecovery();
	}
    
    
    
    
    
    /*@RequestMapping(value = "/test1")
	@ResponseBody
	public Map<String, Object> test1(User entity, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println("kick out : " + entity.getUsername());
		try {
			List<Object> objects = sessionRegistry.getAllPrincipals();
			for (Object o : objects) {
//				shotOff(o);
				User user = (User) o;
//				if (user.getUsername().equals(entity.getUsername())) {
					List<SessionInformation> sis = sessionRegistry.getAllSessions(o, false);
					if (sis != null) {
						for (SessionInformation si : sis) {
							si.expireNow();
							System.out.println(
									si.isExpired() ? "yes,  session be expired" : "no yet,session still active");
							// this.sessionRegistry.removeSessionInformation(si.getSessionId());
							System.out.println("---" + entity.getUsername() + "---have be kick out!");
						}
					}
					result.put("success", true);
//				}
			}
			System.out.println("no one call ---" + entity.getUsername() + "---login");
			String amount = queryLoginUser(0,100);
			result.put("amount", amount);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
    *//**
     * 实现了对当前登录用户的分页查询，并返回Json数据格式。
     * @param start
     * @param limit
     * @return Json数据格式的字符串
     *//*
    public String queryLoginUser(int start,int limit){
		List<Object> slist =sessionRegistry.getAllPrincipals();
		int totalCount=slist.size();
		if(slist.size()==0){
			   return "{totalCount:" + totalCount + ",data:[]}";
		}
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		List<Object> pageList=slist.subList(start,limit>slist.size()?slist.size():limit);
		StringBuffer retVal=new StringBuffer("[");
		int k=0;
		for(int i=0;i<pageList.size();i++){
			List<SessionInformation> sessionList = sessionRegistry.getAllSessions(pageList.get(i),true); 
			User user=(User)pageList.get(i);
			for(SessionInformation t:sessionList){
				if(k!=0){
					retVal.append(",");
				}
			    retVal.append("{\"id\":\""+k+"\",\"userName\":\""+user.getUsername()+"\",\"sessionId\":\""+t.getSessionId()+"\",\"lastRequest\":\""+sdf.format(t.getLastRequest())+"\"}");
			    k=k+1;
			}
		}
		retVal.append("]");
	    return "{totalCount:" + totalCount + ",data:"+ retVal.toString() + "}";
	}
    
    *//** 
     * 把当前用户踢出系统 
     *//*  
    public void shotOff(Object principal) {
        List<SessionInformation> sessionInformations = sessionRegistry.getAllSessions(principal, false);  
        for (SessionInformation sessionInformation : sessionInformations) {
            sessionInformation.expireNow();
            sessionRegistry.removeSessionInformation(sessionInformation.getSessionId());
        }
    }*/
	
}
