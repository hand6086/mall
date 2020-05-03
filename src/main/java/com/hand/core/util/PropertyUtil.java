package com.hand.core.util;

import redis.clients.jedis.Jedis;

public class PropertyUtil {

	//public final static String commonKey = "APPLICATION_PARM_ALL";
	//public final static String corpKeyPrefix = "APPLICATION_PARM_";
	
	/**
	 * 
	 *<p>获取私有参数，无则返回null</p>
	 * @author yrf
	 * @param propertyKey
	 * @param corpId
	 * @return
	 */
	public static String getCropProperty(String propertyKey, String corpId){
		Jedis jedis = RedisUtil.getJedis();
		String key = AppConstants.SYS_PROPERTY_CORP_KEY + corpId;
		return jedis.hget(key, propertyKey);
	}
	
	/**
	 * 
	 *<p>获取公共参数，无则返回null</p>
	 * @author yrf
	 * @param propertyKey
	 * @return
	 */
	public static String getCommonProperty(String propertyKey){
		Jedis jedis = RedisUtil.getJedis();
		return jedis.hget(AppConstants.SYS_PROPERTY_COMMON_KEY, propertyKey);
	}
	
	/**
	 * 
	 *<p>获取参数，先从私有参数找，无则从公共参数里找</p>
	 * @author yrf
	 * @param propertyKey
	 * @param corpId
	 * @return
	 */
	public static String getProperty(String propertyKey, String corpId){
		Jedis jedis = RedisUtil.getJedis();
		String key = AppConstants.SYS_PROPERTY_CORP_KEY + corpId;
		String corpProperty = jedis.hget(key, propertyKey);
		if(StringUtils.isBlank(corpProperty)){
			return jedis.hget(AppConstants.SYS_PROPERTY_COMMON_KEY, propertyKey);
		}
		return corpProperty;
	}
}
