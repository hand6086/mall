package com.hand.core.util;

import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.apache.http.HttpResponse;
import org.apache.http.util.EntityUtils;

import com.alibaba.fastjson.JSONObject;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import redis.clients.jedis.Jedis;

/**
 * 
 * <p>短信发送</p>
 * <p>Description</p>
 * <p>Company</p>
 * @author yrf
 * @date 2017年3月16日  下午5:15:15
 */
public class MsgUtil {

	/**每天所能发送短信的总次数*/
	public static final int allPhoneNumSendTimesLimitOneDay = 1000;
	
	/**每天每个手机号所能发送短信的次数*/
	public static final int singlePhoneNumSendTimesLimitOneDay = 10;
	
	/**短信发送平台主机*/
	public static final String host = "http://sms.market.alicloudapi.com";
	/**路径*/
	public static final String path = "/singleSendSms";
	/** 方法*/
    public static final String method = "GET";
    
    /**短信发送平台用于验证的key*/
    private static final String appCode = "APPCODE 43eae9246ced4b228d8f4dffe47b99e9";
    
    /**产品签名,不能随便改，需要与阿里云的信息对应上*/
    public static final String signName = "Link产品";
    
    /**计算总发送短信次数key；后面拼接上手机号表示该手机号的短信发送次数 */
    public static final String redisKeyForMsgTotalPrefix = "MsgCounter#"; 
   
    /**某手机号已接收信息次数（当天）*/
    public static final String redisFieldTotal= "Total";
    
    /**手机号（当天）首次接收信息的系统时刻，毫秒*/
    public static final String redisFieldTime = "Time";
    
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Map<String, String> param = new HashMap<String, String>();
        param.put("no", "224512");
        System.out.println(MsgUtil.sendMsg("", "SMS_50065081", param, "VertificationCode"));
	}
	
	/**
	 * 
	 *<p>发送短信</p>
	 * @author yrf
	 * @param phoneNumber 手机号
	 * @param templateCode 短信模板编码
	 * @param param 发送短信内容
	 * @return
	 */
	private static String send(String phoneNumber, String templateCode, Map<String, String> param){
        Map<String, String> headers = new HashMap<String, String>();
        headers.put("Authorization", appCode);//认证
        Map<String, String> querys = new HashMap<String, String>();
    	querys.put("ParamString", (String) JSONObject.toJSONString(param));
        querys.put("RecNum", phoneNumber);//手机号
        querys.put("SignName", signName);//签名,不能随便改，需要与阿里云的信息对应上
        querys.put("TemplateCode", templateCode);//信息模板,不能随便改，需要与阿里云的信息对应上
        try {
            HttpResponse response = HttpUtils.doGet(host, path, method, headers, querys);
            String resultStr = EntityUtils.toString(response.getEntity());
            System.out.println("短信发送["+phoneNumber+"]: "+resultStr);
            return resultStr;
        } catch (Exception e) {
            e.printStackTrace();
            String str = "{\"success\":false,\"result\":\""+e.getMessage()+"\"}";
            return str;
        }
		//return null;
	}
	
	/**
	 * 
	 *<p>校验并发送短信，发送次数加一</p>
	 * @author yrf
	 * @param phoneNumber 手机号
	 * @param templateCode 短信模板编码
	 * @param param 发送短信内容
	 * @param msgType 短信类型(不为null则保存短信内容24小时)
	 * @return json字符串
	 */
	public static String sendMsg(String phoneNumber, String templateCode, Map<String, String> param, String msgType){
		String beforeSendResult = beforeSend(phoneNumber);
		if(beforeSendResult != null){
			return beforeSendResult;
		}
		String sendResult = send(phoneNumber,templateCode,param);
		if(sendResult != null && sendResult.contains("\"success\":true")){
			System.out.println("true");
			afterSend(phoneNumber);
			if(!StringUtils.isBlank(msgType)){
				upsertMsgType(phoneNumber, templateCode, param, msgType);
			}
			return sendResult;
		}else if(sendResult != null){
			return sendResult;
		}else{
			return "{\"success\":false,\"result\":null}";
		}
	}
	
	/**
	 * 
	 *<p>校验并发送短信，发送次数加一</p>
	 * @author yrf
	 * @param phoneNumber 手机号
	 * @param templateCode 短信模板编码
	 * @param param 发送短信内容
	 * @param msgType 短信类型(不为null则保存短信内容24小时)
	 * @return json字符串
	 */
	public static Map<String, Object> sendMsg2(String phoneNumber, String templateCode, Map<String, String> param, String msgType){
		String resultStr = sendMsg(phoneNumber, templateCode, param, msgType);
		if(resultStr == null ){
			return null;
		}
		Gson gson = new Gson();
        return gson.fromJson(resultStr, new TypeToken<Map<String,Object>>() {}.getType());
	}
	/**
	 * 
	 *<p>保存最近发送短信内容24小时, key为msgType+phoneNumber；Field 'Time' 为发送时间戳（毫秒）</p>
	 * @author yrf
	 * @param phoneNumber 手机号码
	 * @param templateCode 短信模板编码
	 * @param param 短信内容
	 * @param msgType 短信类型
	 */
	private static void upsertMsgType(String phoneNumber, String templateCode, Map<String, String> param, String msgType){
		Jedis jedis = RedisUtil.getJedis();
		String redisKey = msgType+phoneNumber;
		jedis.hmset(redisKey, param);
		jedis.hset(redisKey, "Time", String.valueOf(System.currentTimeMillis()));
		jedis.hset(redisKey, "TemplateCode", templateCode);
		jedis.expire(redisKey, 24 * 60 * 60);
	}
	/**
	 * 
	 *<p>短信发送前校验，返回null表示校验通过</p>
	 * @author yrf
	 * @param phoneNumber
	 * @return json字符串
	 */
	private static String beforeSend(String phoneNumber){
		Jedis jedis = RedisUtil.getJedis();
		String redisKey = redisKeyForMsgTotalPrefix+phoneNumber;
		Long startTime = getThisDayStartTime();
		Long endTime = getThisDayEndTime();
		String totalStr = jedis.hget(redisKey, redisFieldTotal);//该号码当天已发送次数
		String timeStr = jedis.hget(redisKey, redisFieldTime);//该号码当天第一次发送时间
		
		/** 发送总次数校验 */
		String allTotalStr = jedis.hget(redisKeyForMsgTotalPrefix, redisFieldTotal);//当天已发送总次数
		String allTimeStr = jedis.hget(redisKeyForMsgTotalPrefix, redisFieldTime);//当天开始统计时间
		if(allTotalStr != null && allTimeStr != null){
			int allTotal = Integer.valueOf(allTotalStr);
			long allTime = Long.valueOf(allTimeStr);
			if(startTime <= allTime && allTime <= endTime){
				if(allTotal >= allPhoneNumSendTimesLimitOneDay){
					String errorMsg = "您好，很抱歉当前系统发送验证码次数已超出限制，今天暂时内无法再发送信息！";
					return "{\"success\":false,\"result\":\""+errorMsg+"\"}";
				}
			}
		}
		
		/** 当前手机号发送次数校验 */
		if(totalStr == null || timeStr == null){
			return null;
		}else{
			int total = Integer.valueOf(totalStr);
			long time = Long.valueOf(timeStr);
			if(time >= startTime && endTime >= time){
				//该手机号的发送统计信息时间当天内有效
				if(total >= singlePhoneNumSendTimesLimitOneDay){
					String errorMsg = "该号码【"+phoneNumber+"】今天发送"+total+"次，请勿频繁发送";
					return "{\"success\":false,\"result\":\""+errorMsg+"\"}";
				}
			}
			
		}
		return null;
	}
	
	/**
	 * 
	 *<p>发送短信后设置已发送次数加一</p>
	 * @author yrf
	 * @param phoneNumber
	 */
	private static void afterSend(String phoneNumber){
		Jedis jedis = RedisUtil.getJedis();
		String redisKey = redisKeyForMsgTotalPrefix+phoneNumber;
		Long timeStamp = System.currentTimeMillis();
		Long startTime = getThisDayStartTime();
		Long endTime = getThisDayEndTime();
		String totalStr = jedis.hget(redisKey, redisFieldTotal);
		String timeStr = jedis.hget(redisKey, redisFieldTime);
		
		/** 发送总次数加一 */
		String allTotalStr = jedis.hget(redisKeyForMsgTotalPrefix, redisFieldTotal);//当天已发送总次数
		String allTimeStr = jedis.hget(redisKeyForMsgTotalPrefix, redisFieldTime);//当天开始统计时间
		if(allTotalStr != null && allTimeStr != null){
			int allTotal = Integer.valueOf(allTotalStr);
			//long allTime = Long.valueOf(allTimeStr);
			jedis.hset(redisKeyForMsgTotalPrefix, redisFieldTotal, String.valueOf(allTotal + 1));
			jedis.hset(redisKeyForMsgTotalPrefix, redisFieldTime, String.valueOf(timeStamp));
		}else{
			jedis.hset(redisKeyForMsgTotalPrefix, redisFieldTotal, "1");
			jedis.hset(redisKeyForMsgTotalPrefix, redisFieldTime, String.valueOf(timeStamp));
		}
		
		/** 手机号发送次数加一 */
		if(totalStr == null || timeStr == null){
			jedis.hset(redisKey, redisFieldTotal, "1");
			jedis.hset(redisKey, redisFieldTime, String.valueOf(timeStamp));
			jedis.expire(redisKey, (int) ((endTime - timeStamp) / 1000) );
		}else{
			int total = Integer.valueOf(totalStr);
			long time = Long.valueOf(timeStr);
			if(time >= startTime && endTime >= time){
				//该手机号的发送统计信息时间当天内有效
				jedis.hset(redisKey, redisFieldTotal, String.valueOf(total +1 ));
			}else{
				jedis.hset(redisKey, redisFieldTotal, "1");
				jedis.hset(redisKey, redisFieldTime, String.valueOf(timeStamp));
				jedis.expire(redisKey, (int) ((endTime - timeStamp) / 1000) );
			}
		}
	}
	
	/**
	 * 
	 *<p>获取当天开始时间（00：00：00）的毫秒数</p>
	 * @author yrf
	 * @return
	 */
	public static long getThisDayStartTime(){
		Calendar calendar = Calendar.getInstance();
	    calendar.setTime(new Date());
	    calendar.set(Calendar.HOUR_OF_DAY, 0);
	    calendar.set(Calendar.MINUTE, 0);
	    calendar.set(Calendar.SECOND, 0);
	    Date start = calendar.getTime();
		return start.getTime();
	}
	
	/**
	 * 
	 *<p>获取当天结束时间（23：59：59）的毫秒数</p>
	 * @author yrf
	 * @return
	 */
	public static long getThisDayEndTime(){
		Calendar calendar = Calendar.getInstance();
	    calendar.setTime(new Date());
	    calendar.set(Calendar.HOUR_OF_DAY, 23);
	    calendar.set(Calendar.MINUTE, 59);
	    calendar.set(Calendar.SECOND, 59);
	    Date end = calendar.getTime();
		return end.getTime();
	}
}
