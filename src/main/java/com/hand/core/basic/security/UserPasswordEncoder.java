package com.hand.core.basic.security;

import org.springframework.security.authentication.encoding.PasswordEncoder;

import com.hand.core.util.PasswordUtil;

public class UserPasswordEncoder implements PasswordEncoder{

	@Override
	public String encodePassword(String rawPass, Object salt) {
		return null;
	}

	@Override
	public boolean isPasswordValid(String encPass, String rawPass, Object salt) {
		
		return PasswordUtil.isEquals(rawPass, encPass);
	}

}
