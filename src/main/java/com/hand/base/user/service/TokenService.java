package com.hand.base.user.service;


import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.user.model.Token;

public interface TokenService extends BasicService<Token>{
	
	/**
	 * 接口根据用户名密码登录
	 * @param username
	 * @param password
	 * @return
	 * @throws BasicServiceException
	 */
	public Token login(String username, String password) throws BasicServiceException;
	
	/**
	 * 根据token串查询corp_id, 加密key
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
	 * 接口更新Token
	 * @param record
	 */
	public void updateTokenValidTime(Token record);
	
}
