package com.hand.base.rongcloud.controller;

import java.io.IOException;
import java.net.MalformedURLException;
import java.text.SimpleDateFormat;
import java.util.*;

import com.alibaba.fastjson.JSONObject;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.rongcloud.model.RcsEmail;
import com.hand.base.smscode.dao.mybatis.mapper.SystemConfigMapper;
import com.hand.base.user.dao.mybatis.mapper.UserMapper;
import com.hand.base.user.model.User;
import com.hand.core.util.*;
import org.apache.commons.lang.StringUtils;
import org.apache.http.HttpResponse;
import org.apache.http.util.EntityUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.service.BasicService;
import com.hand.base.rongcloud.model.RcsManager;
import com.hand.base.rongcloud.model.RcsMerchant;
import com.hand.base.rongcloud.model.ResponsePcResult;
import com.hand.base.rongcloud.service.RcsManagerService;
import com.hand.base.rongcloud.service.RcsMerchantService;
import com.hand.base.basic.service.LovService;
import io.rong.RongCloud;
import io.rong.methods.user.onlinestatus.OnlineStatus;
import io.rong.models.Result;
import io.rong.models.response.CheckOnlineResult;
import io.rong.models.response.TokenResult;
import io.rong.models.user.UserModel;

@RestController
@RequestMapping("/action/portal/manager")
public class RcsManagerController extends BasicController<RcsManager>{
	private static final Logger logger =
			LogManager.getLogger(RcsManagerController.class);

	@Autowired
	public RcsManagerService managerService;

	@Autowired
	public RcsMerchantService merchantService;

	@Autowired
	public LovService LovService;

	@Autowired
	private SystemConfigMapper configMapper;

	@Autowired
	private UserMapper userMapper;

	@Override
	public BasicService<RcsManager> getBasicService() throws Exception {
		return managerService;
	}

	//获取token和APPkey
	@RequestMapping(value="/getKey",method=RequestMethod.POST)
	public String getKey(String managerId) {
		if(managerId == null) {
			return new ResponsePcResult(null,null,null,null,1,"请输入管理员Id").toString();
		}

		try {
			RcsManager manager = new RcsManager();
			manager.setId(managerId);
			manager = managerService.queryById(manager);
			if(manager == null) {
				return new ResponsePcResult(null,null,null,null,1,"管理员不存在").toString();
			}

			if(StringUtils.isEmpty(manager.getManagerToken())) {
				//注册用户，获取token并返回
				TokenResult result  = registUser(manager);
				if(result.getCode().intValue() == 200 ) {
					return new ResponsePcResult(result.getToken(),
							AppConstants.appKey,manager.getName(),manager.getPortrait(),100,"请求成功").toString();
				}
			}
			//直接返回
			return new ResponsePcResult(manager.getManagerToken(),
					AppConstants.appKey,manager.getName(),manager.getPortrait(),100,"请求成功").toString();
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
			return new ResponsePcResult(null,
					AppConstants.appKey,null,null,1,"获取token异常").toString();
		}

	}


	public TokenResult registUser(RcsManager  manager) throws Exception {

		UserModel registUser = new UserModel()
		        .setId("kf_"+manager.getId()+"")
		        .setName(manager.getName())
		        .setPortrait(manager.getPortrait());
		TokenResult result = RongCloud.getInstance(AppConstants.appKey, AppConstants.appSecret).user.register(registUser);

		manager.setManagerToken(result.getToken());
        if(result.getCode().intValue() == 200) {
       	  //向数据库添加用户信息Token
       	  managerService.update(manager);
        }
        return  result;
	}


	//根据店铺ID获取客服ID
	@RequestMapping(value="/getManagerId",method=RequestMethod.POST)
	public TokenResult getManagerId(String merchantId) {

		try {

			RcsMerchant  merchant = new RcsMerchant();
			merchant.setId(merchantId);
			merchant = merchantService.queryById(merchant);

			if (merchant == null) {
                String name = configMapper.getByCode("ZH_KF_NAME");
                String userId = configMapper.getByCode("ZH_KF_ID");
                String portrait = AppConstants.portalStaticUrl + "/static/images/404.jpg";
                if (StringUtils.isBlank(name) || StringUtils.isBlank(userId)) {
                    return new TokenResult(null, null, 1, null, null, "客服不在线", false);
                }
                return new TokenResult(name, portrait, 100, null, userId, "查询客服成功", true);
			}

			RcsManager rcsManager = new RcsManager();
			rcsManager.setPageFlag(false);
			rcsManager.setMerchantId(merchantId);
			List<RcsManager> managers = managerService.queryByExamplePage(rcsManager);
			if (managers.size() == 0) {
                String name = configMapper.getByCode("ZH_KF_NAME");
                String userId = configMapper.getByCode("ZH_KF_ID");
                String portrait = AppConstants.portalStaticUrl + "/static/images/404.jpg";
                if (StringUtils.isBlank(name) || StringUtils.isBlank(userId)) {
                    return new TokenResult(null, null, 1, null, null, "客服不在线", false);
                }
                return new TokenResult(name, portrait, 100, null, userId, "查询客服成功", true);
			}

			Random ran = new Random();
			RcsManager manager = managers.get(ran.nextInt(managers.size()));
			//获取独立源代码
			String userId = LovService.getLovValue("ZHICHI_MAILBOX", manager.getZhMail());


			if (StringUtils.isBlank(userId)) {
                userId = configMapper.getByCode("ZH_KF_ID");
			}

			/*if(!checkOnLine(managerId)) {
				return new TokenResult(null,null,1, null, managerId+ "","客服不在线",false);
			}*/
			return new TokenResult(manager.getName(), manager.getPortrait(), 100,
					null, userId, "查询客服成功", true);
		} catch (BasicServiceException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            String name = configMapper.getByCode("ZH_KF_NAME");
            String userId = configMapper.getByCode("ZH_KF_ID");
            String portrait = AppConstants.portalStaticUrl + "/static/images/404.jpg";
            if (StringUtils.isBlank(name) || StringUtils.isBlank(userId)) {
                return new TokenResult(null, null, 1, null, null, "客服不在线", false);
            }
            return new TokenResult(name, portrait, 100, null, userId, "查询客服成功", true);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
			return new TokenResult(null, null, 1, null, null, "查询客服异常", false);
		}

	}


	private boolean checkOnLine(String managerId) throws MalformedURLException, IOException, Exception {
		OnlineStatus onLineStatus = new OnlineStatus(AppConstants.appKey,AppConstants.appSecret);
		RongCloud rongCloud = RongCloud.getInstance(AppConstants.appKey, AppConstants.appSecret);
		onLineStatus.setRongCloud(rongCloud);
		CheckOnlineResult onlineResult = onLineStatus.check(new UserModel(managerId, null, null));
		//返回码，200 为正常。
		if (onlineResult.getCode().intValue() == 200) {
			//在线状态，1为在线，0为不在线。
			String status = onlineResult.getStatus();
			if("1".equals(status)) {
				return true;
			}
		}
		return false;
	}

	//当用户头像，名称，Id发生改变是刷新用户在融云上的信息
	@RequestMapping(value="/refreshManagerInfo",method=RequestMethod.POST)
	@ResponseBody
	public Result refreshManagerInfo(String userId,String name,String portrait) throws Exception {
		if(StringUtils.isEmpty(userId))
			return null;
		if(StringUtils.isEmpty(name) && StringUtils.isEmpty(portrait))
			return null;
		RcsManager manager = new RcsManager();
		manager.setId(userId);
		manager = managerService.queryById(manager);
		if(manager != null){
			name = StringUtils.isEmpty(name) ? manager.getName():name;
			portrait = StringUtils.isEmpty(portrait) ? manager.getPortrait():portrait;
			UserModel refreshUser = new UserModel()
					 .setId(userId)
					 .setName(name)
					 .setPortrait(portrait);
			//刷新用户信息
			Result refreshResult = RongCloud.getInstance(AppConstants.appKey, AppConstants.appSecret).user.update(refreshUser);
			return refreshResult;
		}
		return null;
	}

	//获取智齿AccessToken
	@RequestMapping(value = "/getAccessToken", method = RequestMethod.POST)
	public String getAccessToken() {
		try {
			String appId = configMapper.getByCode("ZH_APP_ID");//获取智齿APPID
			String appKey = configMapper.getByCode("ZH_APP_KEY");//获取智齿APPKEY
			Long createTime = Calendar.getInstance().getTimeInMillis();//获取当前时间
			String sign = com.hand.core.util.StringUtils.md5(appId+appKey+createTime);//获取签名
			Map<String, String> headers = new HashMap<String, String>();
			Map<String, String> querys = new HashMap<String, String>();
			querys.put("appId", appId);
			querys.put("createTime", Long.toString(createTime));//手机号
			querys.put("sign", sign);//签名,不能随便改，需要与阿里云的信息对应上
			HttpResponse response = HttpUtils.doGet("https://open.sobot.com/open/platform", "/getAccessToken.json", "GET", headers, querys);
			String resultStr = EntityUtils.toString(response.getEntity());
			System.out.println(resultStr);
			return resultStr;
		} catch (Exception e) {
			e.printStackTrace();
			String str = "{\"code\":1001,\"result\":\""+e.getMessage()+"\"}";
			return str;
		}
	}

	//获取智齿工作平台URL
	@RequestMapping(value = "/getConsoleDirectUrl", method = RequestMethod.POST)
	public String getConsoleDirectUrl(User user) {
		if(StringUtils.isEmpty(user.getId())){
			String str = "{\"code\":1001,\"result\":\"获取用户信息失败;\"}";
			return str;
		}
		String accessTokenStr = getAccessToken();
		JSONObject accessTokenJson = JSONObject.parseObject(accessTokenStr);
		if(!"1000".equals(accessTokenJson.get("code").toString())){
			String str = "{\"code\":1001,\"result\":\"获取accessToken失败;\"}";
			return str;
		}
		JSONObject data = JSONObject.parseObject(accessTokenJson.get("data").toString());
		String action = "console_direct_url";
		String access_token = data.get("access_token").toString();
		try {
			user = userMapper.queryByUserId(user);
			if(StringUtils.isEmpty(user.getZhEmail())){
				String str = "{\"code\":1001,\"result\":\"您的智齿邮箱未维护;\"}";
				return str;
			}
			JSONObject json = new JSONObject();
			json.put("email", user.getZhEmail());
			json.put("type", "1");
			JSONObject obj = new JSONObject();
			obj.put("action", action);
			obj.put("access_token", access_token);
			obj.put("data", json.toJSONString());
			String content = obj.toJSONString();
			String result = HttpRequestUtil.sendPost("https://open.sobot.com/open/platform/api.json",content,null);
			System.out.println(result);
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			String str = "{\"success\":false,\"result\":\""+e.getMessage()+"\"}";
			return str;
		}
	}

	//查询用户会话列表
	@RequestMapping(value = "/getChatUserQueryCids", method = RequestMethod.POST)
	public String getChatUserQueryCids() {
		String accessTokenStr = getAccessToken();
		JSONObject accessTokenJson = JSONObject.parseObject(accessTokenStr);
		if(!"1000".equals(accessTokenJson.get("code").toString())){
			String str = "{\"code\":1001,\"result\":\"获取accessToken失败;\"}";
			return str;
		}
		JSONObject data = JSONObject.parseObject(accessTokenJson.get("data").toString());
		String action = "chat_user_query_cids";
		String access_token = data.get("access_token").toString();
		try {
			JSONObject json = new JSONObject();
			json.put("sysNum", "1103f28a359d4bb4b17955cbf8fb55ea");
			json.put("partnerId", "QT-44T2");
			JSONObject obj = new JSONObject();
			obj.put("action", action);
			obj.put("access_token", access_token);
			obj.put("data", json.toJSONString());
			String content = obj.toJSONString();
			String result = HttpRequestUtil.sendPost("https://open.sobot.com/open/platform/api.json",content,"application/json");
			System.out.println(result);
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			String str = "{\"success\":false,\"result\":\""+e.getMessage()+"\"}";
			return str;
		}
	}

    //	智齿邮箱的在线客服消息  --消息转发

    @RequestMapping(value = "/zcInsert", method = RequestMethod.POST)
    @ResponseBody
    public String zcInsert(@RequestBody Map<String, Object> map) {
        //JSONObject obj = new JSONObject();
        String result = "";
        try {
            String type = map.get("type").toString();

            boolean contains = map.containsKey(type);
            List<RcsEmail> content = new Gson().fromJson(new Gson().toJson(map.get("content")), new TypeToken<List<RcsEmail>>() {
            }.getType());
            SimpleDateFormat sf2 = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
            if ("conversation".equals(type)) {
                //   会话消息
                //获取开始时间和结束时间的毫秒数   转换为年月日
                for (RcsEmail rcsEmail : content) {
                    //重新设置type
                    rcsEmail.setType("conversation");
                    if (!StringUtils.isBlank(rcsEmail.getStartTime())) {
                        rcsEmail.setStartTime(sf2.format(new Long(rcsEmail.getStartTime())));
                    }
                    if (!StringUtils.isBlank(rcsEmail.getEndTime())) {
                        rcsEmail.setEndTime(sf2.format(new Long(rcsEmail.getEndTime())));
                    }
//					用户来源
                    String source = rcsEmail.getSource();
                    if ("0".equals(source)) {
                        rcsEmail.setSource("pc");
                    } else if ("1".equals(source)) {
                        rcsEmail.setSource("微信");
                    } else if ("2".equals(source)) {
                        rcsEmail.setSource("sdk");
                    } else if ("3".equals(source)) {
                        rcsEmail.setSource("微博");
                    } else if ("4".equals(source)) {
                        rcsEmail.setSource("移动网站");
                    } else if ("9".equals(source)) {
                        rcsEmail.setSource("企业微信");
                    } else if ("10".equals(source)) {
                        rcsEmail.setSource("微信小程序");
                    }
//					操作系统
                    String os = rcsEmail.getOs();
                    if ("1".equals(os)) {
                        rcsEmail.setOs("Windows XP");
                    } else if ("2".equals(os)) {
                        rcsEmail.setOs("Windows 7");
                    } else if ("3".equals(os)) {
                        rcsEmail.setOs("Windows 8");
                    } else if ("4".equals(os)) {
                        rcsEmail.setOs("Windows Vista");
                    } else if ("5".equals(os)) {
                        rcsEmail.setOs("Windows 其他");
                    } else if ("6".equals(os)) {
                        rcsEmail.setOs("Linux");
                    } else if ("7".equals(os)) {
                        rcsEmail.setOs("macOS");
                    } else if ("8".equals(os)) {
                        rcsEmail.setOs("Android");
                    } else if ("9".equals(os)) {
                        rcsEmail.setOs("iOS");
                    } else if ("11".equals(os)) {
                        rcsEmail.setOs("Windows 2000");
                    } else if ("12".equals(os)) {
                        rcsEmail.setOs("Windows 10");
                    } else if ("其他".equals(os)) {
                        rcsEmail.setOs("其他");
                    }
//					排队状态
                    String sessionQueueState = rcsEmail.getSessionQueueState();
                    if ("1".equals(sessionQueueState)) {
                        rcsEmail.setSessionQueueState("未排队接通");
                    } else if ("2".equals(sessionQueueState)) {
                        rcsEmail.setSessionQueueState("排队接通");
                    } else if ("3".equals(sessionQueueState)) {
                        rcsEmail.setSessionQueueState("排队离开");
                    }

                    managerService.zcInsert(rcsEmail);
                }

            } else if ("msg".equals(type)) {
                //  聊天消息
                for (RcsEmail rcsEmail : content) {
                    rcsEmail.setType("msg");
                    //	发送类型
                    String senderType = rcsEmail.getSenderType();
                    if ("0".equals(senderType)) {
                        rcsEmail.setSenderType("访客");
                    } else if ("1".equals(senderType)) {
                        rcsEmail.setSenderType("机器人");
                    } else if ("2".equals(senderType)) {
                        rcsEmail.setSenderType("客服");
                    }
                    // 接收类型
                    String receiverType = rcsEmail.getReceiverType();
                    if ("0".equals(receiverType)) {
                        rcsEmail.setReceiverType("访客");
                    } else if ("1".equals(receiverType)) {
                        rcsEmail.setReceiverType("机器人");
                    } else if ("2".equals(receiverType)) {
                        rcsEmail.setReceiverType("客服");
                    }
                    managerService.zcInsert(rcsEmail);
                    if(!"1".equals(rcsEmail.getPartnerIdFlag())){
                        String msg = rcsEmail.getMsg();
                        if (msg.indexOf("class=\"webchat_voice\"") != -1) {
                            rcsEmail.setMsg("[语音]");
                        } else if (msg.indexOf("class=\"webchat_img_upload upNowImg uploadedFile\"") != -1) {
                            rcsEmail.setMsg("[图片]");
                        } else if (msg.indexOf("class='webchat_img_upload'") != -1) {
                            rcsEmail.setMsg("[图片]");
                        } else if (msg.indexOf("class=\"uploadedFile\"") != -1) {
                            rcsEmail.setMsg("[文件]");
                        } else {
                            rcsEmail.setMsg(msg.replace("<br>", " "));
                        }
                        managerService.updateZcByCid(rcsEmail);
                    } else if("1".equals(rcsEmail.getPartnerIdFlag()) && !StringUtils.isBlank(rcsEmail.getStoreId())
							&& !StringUtils.isBlank(rcsEmail.getPartnerId())){
						RcsEmail msg = new RcsEmail();
						msg.setStoreId(rcsEmail.getStoreId());
						msg.setStoreName(rcsEmail.getStoreName());
						msg.setStoreLogo(rcsEmail.getStoreLogo());
						msg.setUserId(rcsEmail.getPartnerId());
						msg.setCid(rcsEmail.getCid());
						RcsEmail lastMsg = managerService.queryLastMsg(msg);
						if(lastMsg != null ){
                            String msgStr = lastMsg.getMsg();
                            if (msgStr.indexOf("class=\"webchat_voice\"") != -1) {
                                msg.setMsg("[语音]");
                            } else if (msgStr.indexOf("class=\"webchat_img_upload upNowImg uploadedFile\"") != -1) {
                                msg.setMsg("[图片]");
                            } else if (msgStr.indexOf("class='webchat_img_upload'") != -1) {
                                msg.setMsg("[图片]");
                            } else if (msgStr.indexOf("class=\"uploadedFile\"") != -1) {
                                msg.setMsg("[文件]");
                            } else {
                                msg.setMsg(msgStr.replace("<br>", " "));
                            }
							msg.setStaffId(lastMsg.getStaffId());
							msg.setTime(lastMsg.getTime());
							List<RcsEmail> msgList = managerService.queryMsgList(msg);
							if(msgList.size() != 0){
								RcsEmail oldMsg = msgList.get(0);
								msg.setId(oldMsg.getId());
								managerService.updateZcList(msg);
							}else {
								managerService.insertZcList(msg);
							}
						}
					}
                }

            } else if ("evaluation".equals(type)) {
                //   评价信息
                for (RcsEmail rcsEmail : content) {
                    rcsEmail.setType("evaluation");
                    if (!StringUtils.isBlank(rcsEmail.getDatetime())) {
                        rcsEmail.setDatetime(sf2.format(new Long(rcsEmail.getDatetime())));
                    }
                    //	用户来源
                    String source = rcsEmail.getSource();
                    if ("0".equals(source)) {
                        rcsEmail.setSource("pc");
                    } else if ("1".equals(source)) {
                        rcsEmail.setSource("微信");
                    } else if ("2".equals(source)) {
                        rcsEmail.setSource("sdk");
                    } else if ("3".equals(source)) {
                        rcsEmail.setSource("微博");
                    } else if ("4".equals(source)) {
                        rcsEmail.setSource("移动网站");
                    } else if ("9".equals(source)) {
                        rcsEmail.setSource("企业微信");
                    } else if ("10".equals(source)) {
                        rcsEmail.setSource("微信小程序");
                    }
                    managerService.zcInsert(rcsEmail);
                }

            } else if ("user".equals(type)) {
                //   用户访客信息
                for (RcsEmail rcsEmail : content) {
                    rcsEmail.setType("user");
                    managerService.zcInsert(rcsEmail);
                }
            } else if ("staff".equals(type)) {
                //   客服信息
                for (RcsEmail rcsEmail : content) {
                    rcsEmail.setType("staff");
                    managerService.zcInsert(rcsEmail);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
//			错误返回错误信息
            result = e.getMessage();
        }
        return result;
    }


}
