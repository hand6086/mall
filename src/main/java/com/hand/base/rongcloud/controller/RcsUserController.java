package com.hand.base.rongcloud.controller;

import org.apache.commons.lang.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.service.BasicService;
import com.hand.base.rongcloud.model.RcsManager;
import com.hand.base.rongcloud.model.RcsUser;
import com.hand.base.rongcloud.service.RcsManagerService;
import com.hand.base.rongcloud.service.RcsMerchantService;
import com.hand.base.rongcloud.service.RcsUserService;
import com.hand.core.util.AppConstants;

import io.rong.RongCloud;
import io.rong.models.Result;
import io.rong.models.response.TokenResult;
import io.rong.models.user.UserModel;

@Controller
@RequestMapping("/action/portal/rcstoken")
public class RcsUserController  extends BasicController<RcsUser>{
	
	private static final Logger logger = 
			LogManager.getLogger(RcsUserController.class);
	
	@Autowired
	public RcsUserService userService;
	
	@Autowired
	public RcsMerchantService merchantService;
	
	@Autowired
	public RcsManagerService managerService;
	
	@Override
	public BasicService<RcsUser> getBasicService() throws Exception {
		return userService;
	}
	
	//根据用户电话号码获取token
	@RequestMapping(value="/getToken",method=RequestMethod.POST)
	@ResponseBody
	public TokenResult getTokenByPhone(String phoneNum){
		
		if(phoneNum == null ) {
			return new TokenResult(null,null,1, null,null,"用户信息不能为空");
		}
		
		try {
			
			RcsUser user = new RcsUser();
			user.setPageFlag(false);
			user.setPhonNum(phoneNum);
			user = userService.queryByExamplePage(user).get(0);
			
			//判断用户是否存在
			if(user == null) {
				return new TokenResult(null,null,1, null,null,"当前用户不存在");
			}
			
			//token存在则直接返回,反之向融云注册用户
			String token = user.getRongToken();
			if(StringUtils.isEmpty(token)){
					registUser(user);
			}
			//返回信息
			return new TokenResult(user.getName(),user.getPortrait(),100, user.getRongToken(), user.getId(),"请求成功");
			
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
			return new TokenResult(null,null,1, null, null,"获取token发生异常");
		}
		
	}
	
	//获取用户信息
	@RequestMapping(value="/userInfo",method=RequestMethod.POST)
	@ResponseBody
	public TokenResult getUserInfo(String userId) {
		try {
			if(userId.startsWith("kf_")){
				RcsManager manager = new RcsManager();
				manager.setId(userId.substring(3));
				manager = managerService.queryById(manager);
				if(manager != null){
					return new TokenResult(manager.getName(),manager.getPortrait(),100, null, userId ,"请求成功");
				}
			}else{
				RcsUser user = new RcsUser();
				user.setId(userId);
				user = userService.queryById(user);
				if(user != null){
					return new TokenResult(user.getName(),user.getPortrait(),100, null , userId,"请求成功");
				}
			}
			return new TokenResult(null,null,1, null, userId,"查询用户信息失败");
		} catch (Exception e) {
			e.printStackTrace();
			return new TokenResult(null,null,1, null, userId,"查询用户信息失败");
		}
	}
	
	//向融云注册用户信息
	public TokenResult registUser(RcsUser user) throws Exception {
		UserModel registUser = new UserModel()
		        .setId(user.getId()+"")
		        .setName(user.getName())
		        .setPortrait(user.getPortrait());
		TokenResult result = RongCloud.getInstance(AppConstants.appKey, AppConstants.appSecret).user.register(registUser);
	        user.setRongToken(result.getToken());
	        if(result.getCode().intValue() == 200) {
	         	  //向数据库添加用户信息Token
	        	userService.update(user);
	        }
	    return  result;
	}
	
	//当用户头像，名称，Id发生改变是刷新用户在融云上的信息
	@RequestMapping(value="/refreshUserInfo",method=RequestMethod.POST)
	@ResponseBody
	public TokenResult refreshUserInfo(String userId,String name,String portrait) throws Exception {
		if(StringUtils.isEmpty(userId))
			return new TokenResult(null,null,1, null, null,"userId为空");
		if(StringUtils.isEmpty(name) && StringUtils.isEmpty(portrait))
			return new TokenResult(null,null,1, null, null,"name 和 portrait 同时为空");
		RcsUser user = new RcsUser();
		user.setId(userId);
		user = userService.queryById(user);
		if(user != null){
			name = StringUtils.isEmpty(name) ? user.getName():name;
			portrait = StringUtils.isEmpty(portrait) ? user.getPortrait():portrait;
			UserModel refreshUser = new UserModel()
					 .setId(userId)
					 .setName(name)
					 .setPortrait(portrait);
			//刷新用户信息
			Result refreshResult = RongCloud.getInstance(AppConstants.appKey, AppConstants.appSecret).user.update(refreshUser);
			if(refreshResult.getCode() == 200){
				return new TokenResult(null,null,100, null, null,"更新信息成功");
			}
		}
		return new TokenResult(null,null,1, null, null,"更新信息失败");
	}
}
