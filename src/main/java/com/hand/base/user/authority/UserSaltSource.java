package com.hand.base.user.authority;

import org.springframework.security.authentication.dao.SaltSource;
import org.springframework.security.core.userdetails.UserDetails;

public class UserSaltSource implements SaltSource{

	public Object getSalt(UserDetails user) {
		return user;
	}

}
