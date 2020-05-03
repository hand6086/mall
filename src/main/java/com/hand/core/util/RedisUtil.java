package com.hand.core.util;

import redis.clients.jedis.Jedis;

public final class RedisUtil {
	// Redis服务器IP
	private static String ADDR = AppConstants.key_applicationRedisHost;
	// Redis的端口号
	private static int PORT = Integer.valueOf(AppConstants.key_applicationRedisPort);
	
	public static Jedis getJedis() {
		//不用连接池连接
		Jedis jedis = new Jedis(ADDR, PORT);
		jedis.auth("mayi123456");
		return jedis;
	}
	
	public static void returnResource(Jedis jedis) {
		if(jedis !=null)
			jedis.close();
	}
	
	public static void main(String[] args) {
		Jedis jedis = RedisUtil.getJedis();
		String x = jedis.get("abc");
		System.out.println("x is " + x);
	}
    
	/**
	 * 获取linkcrm【参数配置】中的参数值,数据源linkcrm 【参数配置】设计两种：全局（适用所有账套）KEY：APPLICATION_PARM_ALL
	 * 私有（适用某个账套）KEY：APPLICATION_PARM_[公司账套] 私有级别高于全局 parm：field_name 键 corpId 公司账套
	 * return：String 值
	 */
	public static String getRedisApplicationParm(String field_name, String corpId) {
		String field_value = "";
		try {
			// 1、获取redis连接池
			Jedis jedis = RedisUtil.getJedis();
			// 2、获取全局参数
			String value_all = jedis.hget("APPLICATION_PARM_ALL", field_name);
			if (!StringUtils.isNull(value_all))
				field_value = value_all;
			// 3、获取私有参数
			if (!StringUtils.isNull(corpId)) {
				String value_own = jedis.hget("APPLICATION_PARM_" + corpId, field_name);
				if (!StringUtils.isNull(value_own))
					field_value = value_own;
			}
			RedisUtil.returnResource(jedis);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return field_value;
	}
   
}