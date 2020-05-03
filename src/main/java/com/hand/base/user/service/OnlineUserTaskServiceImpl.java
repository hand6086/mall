package com.hand.base.user.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.security.core.session.SessionInformation;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.hand.base.user.model.OnlineUser;
import com.hand.core.basic.query.QueryParams;
import com.hand.core.util.StringUtils;

@Service
@Repository
public class OnlineUserTaskServiceImpl{
	
	@Resource
	private OnlineUserService onlineUserService;
	
	private static final Logger logger = LogManager.getLogger(OnlineUserTaskServiceImpl.class);
	
	
	/**
     * 一)功能：修复数据。
     * 二)原因：由于服务器非正常方式关闭会导致在线用户表不能及时删除数据，导致数据冗余。
     * 三)实现原理：通过遍历匹配服务器上的sessionId和在线用户表的sessionId字段，找出在线用户表的冗余记录，并且删除
     */
	public Map<String, Object> dataRecovery() {
		logger.info("删除在线登录表冗余数据：开始...");
		int tableDataAmount = 0;//表数据总数量
		int onLineAmount = 0;//有效session总数量
		int deleteAmount = 0;//执行删除操作的总次数
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			/*
			List<String> allSessionIdList = new ArrayList<String>();//记录所有的sessionId
			List<Object> objects = sessionRegistry.getAllPrincipals();
			//遍历获取sessionId
			for (Object object : objects) {
				List<SessionInformation> sessionList = sessionRegistry.getAllSessions(object, false);
				if (sessionList != null) {
					for (SessionInformation si : sessionList) {
						if(!StringUtils.isBlank(si.getSessionId())){
							allSessionIdList.add(si.getSessionId());//提取sessionId
						}
					}
				}
			}
			Boolean isOnline = false;//记录 检查用户是否在线的结果
			QueryParams qps = new QueryParams();
			qps.setNoPage(true);
			OnlineUser onlineUser = new OnlineUser();
			onlineUser.setPageFlag(false);
			List<OnlineUser> onlineUserList = onlineUserService.querySessionIdListPage(onlineUser);
			tableDataAmount = onlineUserList.size();//记录表数据总数
			onLineAmount = allSessionIdList.size();//记录有效session总数
			for(OnlineUser entity : onlineUserList){
				isOnline = false;
				for(String sessionId : allSessionIdList){
					if(StringUtils.equals(StringUtils.encryptBySHA1(sessionId), entity.getSessionId())){
						isOnline = true;//标记用户
						break;
					}
				}
				if(!isOnline){
					try {
						onlineUserService.deleteById(entity);
						deleteAmount++;//记录删除操作次数
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}*/
			result.put("success", true);
		} catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		logger.info("实时检测到的有效session总数量为：" + onLineAmount + "。");
		logger.info("实时查询到在线用户表的数据总数量为：" + tableDataAmount + "。");
		logger.info("共对在线用户表执行了" + deleteAmount + "次的删除操作。");
		logger.info("删除在线登录表冗余数据：结束...");
		return result;
	}
}
