package com.hand.base.user.service;

import java.util.Date;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.user.dao.mybatis.mapper.TokenMapper;
import com.hand.base.user.model.Token;
import com.hand.core.util.AppConstants;
import com.hand.core.util.DateUtil;
import com.hand.core.util.StringUtils;


@Service
public class TokenServiceImpl  extends BasicServiceImpl<Token>implements TokenService {
		
	private static final Logger logger = LogManager.getLogger(TokenServiceImpl.class);

	@Resource
	private TokenMapper	tokenMapper;
	@Override
	public BasicMapper<Token> getBasicMapper() {
		return tokenMapper;
	}
	
	@Transactional
	public Token login(String username, String password) {
		logger.info("外部系统调用接口查询token开始...");
		Token queryToken = tokenMapper.queryTokenByUsername(username);
		if(queryToken == null){
			queryToken = new Token();
			queryToken.setSuccess(false);
			queryToken.setCode(AppConstants.INTERFACE_QUERY_USERNAME_ERROR_CODE);
			queryToken.setMessage("账号不存在，请联系管理员！");
			return queryToken;
		}
		
		// 校验密码
		if(!queryToken.getPassword().equals(StringUtils.md5(password))){
			queryToken = new Token();
			queryToken.setSuccess(false);
			queryToken.setCode(AppConstants.INTERFACE_QUERY_PASSWORD_ERROR_CODE);
			queryToken.setMessage("密码校验失败！");
			return queryToken;
		}
		// 校验时间范围
		Date current = DateUtil.ymdhmsParse(queryToken.getCurrent());
		String startDate = queryToken.getStartDate();
		String endDate = queryToken.getEndDate();
		
		if(StringUtils.isNull(startDate) || StringUtils.isNull(endDate) || current.after(DateUtil.ymdhmsParse(endDate)) || current.before(DateUtil.ymdhmsParse(startDate))){
			String tokenStr = StringUtils.token();
			queryToken.setToken(tokenStr);
		}
		tokenMapper.updateToken(queryToken);
		queryToken.setSuccess(true);
		logger.info("外部系统调用接口查询token结束...");
		return queryToken;
	}

	@Override
	public Token queryTokenByToken(String token) {
		return tokenMapper.queryTokenByToken(token);
	}

	@Override
	public void updateTokenValidTime(Token record) {
		tokenMapper.updateTokenValidTime(record);
	}

	@Override
	public Token queryTokenByTokenAndKey(Token token) {
		return tokenMapper.queryTokenByTokenAndKey(token);
	}
}
