package com.hand.base.user.authority;

import java.util.Collection;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;

public class UserAuthenticate implements Authentication{

	private static final long serialVersionUID = -8937702371392970466L;

	public String getName() {
		return null;
	}

	public Collection<? extends GrantedAuthority> getAuthorities() {
		return null;
	}

	public Object getCredentials() {
		return null;
	}

	public Object getDetails() {
		return null;
	}

	public Object getPrincipal() {
		return null;
	}

	public boolean isAuthenticated() {
		return false;
	}

	public void setAuthenticated(boolean isAuthenticated) throws IllegalArgumentException {
		
	}

}
