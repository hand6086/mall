package com.hand.core.util;

import org.springframework.security.authentication.encoding.PasswordEncoder;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;

@SuppressWarnings("deprecation")
public class BasicEncode implements PasswordEncoder{

	public String encodePassword(String rawPass, Object salt) {
		return null;
	}

	public boolean isPasswordValid(String encPass, String rawPass, Object salt) {
		/*
		//SHA 256 加密
		String enCode = sha_SHA_256(rawPass);
		if(enCode.equalsIgnoreCase(encPass)){
			return true;	
		}else{
			return false;
		}
		*/
		return rawPass.equalsIgnoreCase(encPass);
	
	}
	
	public String sha_SHA_256(String str) {     
        ShaPasswordEncoder sha = new ShaPasswordEncoder(256);     
        sha.setEncodeHashAsBase64(false);     
        return sha.encodePassword(str, null);
    }  
}
