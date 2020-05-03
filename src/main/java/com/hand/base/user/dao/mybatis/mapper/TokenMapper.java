package com.hand.base.user.dao.mybatis.mapper;


import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.user.model.Token;

public interface TokenMapper extends BasicMapper<Token>{
	
	/**
	 * 根据token串查询corp_id
	 * @param token
	 * @return
	 */
	public Token queryTokenByToken(String token);
	
	/**
	 * 根据token和key查询corp_id
	 * @param token
	 * @return
	 */
	public Token queryTokenByTokenAndKey(Token token);
	
	/**
	 * 根据用户名查询Token记录
	 * @param username
	 * @return
	 */
	public Token queryTokenByUsername(String username);
	
	/**
	 * 接口登录查询Token
	 * @param record
	 * @return
	 */
	public Token queryToken(Token record);
	
	
	/**
	 * 接口更新Token
	 * @param record
	 */
	public void updateToken(Token record);
	
	/**
	 * 接口更新Token
	 * @param record
	 */
	public void updateTokenValidTime(Token record);
	
}
