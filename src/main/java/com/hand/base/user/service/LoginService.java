package com.hand.base.user.service;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.hand.base.user.dao.mybatis.mapper.LoginMapper;
import com.hand.base.user.model.User;
import com.hand.core.util.DateUtil;
import com.hand.core.util.RedisUtil;
import com.hand.core.util.StringUtils;

import redis.clients.jedis.Jedis;

@Service
public class LoginService implements UserDetailsService{
	
	private static final Logger logger = LogManager.getLogger(LoginService.class);
	
	@Autowired
	private LoginMapper loginMapper;
	
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException,DataAccessException{
		if(username == null || "".equals(username.trim())){
			throw new BadCredentialsException("用户名不能为空！");
		}
		User user = null;
		User example = new User();
		example.setUsername(username.toUpperCase());
		try {
			user = loginMapper.queryByUsername(example);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(user == null){
			throw new BadCredentialsException("用户名或密码错误！");
		} else {
			checkLoginErrorTimes(username.toUpperCase());//只在用户名正确地情况下才去校验错误密码登录的次数
		}
		return user;
	}
	
	/**
	 * 校验用户名对应的登录错误次数
	 * @param username
	 */
	private void checkLoginErrorTimes(String username) {
		Jedis jedis = RedisUtil.getJedis();
		String redisKey = "crm_loginError_info"; // 存放用户密码错误信息
		Map<String, String> map = new HashMap<String, String>();
		String currentdate = DateUtil.getYY_MM_DDHHmmss(new Date()); // 记录当前登录时间
		if (jedis.exists(redisKey) && jedis.hmget(redisKey, username).get(0) != null) {
			if (Integer.parseInt(jedis.hmget(redisKey, username).get(0).split("\\+")[0]) >= User.MAX_LOGIN_ERROR_TIME) {
				Date currentime = new Date();
				Date lasttime = DateUtil.getDateFormat(jedis.hmget(redisKey, username).get(0).split("\\++")[1], "yyyy-MM-dd HH:mm:ss");
				if ((currentime.getTime() - lasttime.getTime()) / (1000 * 60 * 60) < 2) {
					throw new BadCredentialsException("密码输入错误五次以上，账号被锁定，请联系系统管理员解锁！");
				} else {
					jedis.hdel(redisKey, username);
					map.put(username, "0" + "+" + currentdate);
					jedis.hmset(redisKey, map);
				}
			}
		} else {
			map.put(username, 0 + "+" + currentdate);
			jedis.hmset(redisKey, map);
//			j.expire(redisKey, 60 * 10 * 12);
		}
	}
	
	public void lastLoginDateUpdate(User entity) throws Exception {
		if(StringUtils.isBlank(entity.getId())){
			throw new Exception("用户ID不能为空。");
		}
		loginMapper.lastLoginDateUpdate(entity);
	}
	
}
