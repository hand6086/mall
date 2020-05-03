package io.rong.models.response;

import io.rong.models.Result;
import io.rong.util.GsonUtil;

/**
 * getToken 返回结果
 */
public class TokenResult extends Result{
	// 用户 Token，可以保存应用内，长度在 256 字节以内.用户 Token，可以保存应用内，长度在 256 字节以内。
	String token;
	// 用户 Id，与输入的用户 Id 相同.
	String userId;
	
	//用户名称
	String name;
	//用户头像
	String portrait;
	//客服在线状态
	boolean status;
	
	//给APP用
	public TokenResult(String name,String portrait,Integer code, String token, String userId, String errorMessage) {
		this.name = name;
		this.portrait = portrait;
		this.code = code;
		this.token = token;
		this.userId = userId;
		this.msg = errorMessage;
	}
	//给PC端用
	public TokenResult(String name,String portrait,Integer code, String token, String userId, String errorMessage,boolean status) {
		this.name = name;
		this.portrait = portrait;
		this.code = code;
		this.token = token;
		this.userId = userId;
		this.msg = errorMessage;
		this.status=status;
	}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPortrait() {
		return portrait;
	}

	public void setPortrait(String portrait) {
		this.portrait = portrait;
	}


	/**
	 * 设置token
	 *
	 */	
	public void setToken(String token) {
		this.token = token;
	}
	
	/**
	 * 获取token
	 *
	 * @return String
	 */
	public String getToken() {
		return token;
	}
	
	/**
	 * 设置userId
	 *
	 */	
	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	/**
	 * 获取userId
	 *
	 * @return String
	 */
	public String getUserId() {
		return userId;
	}
	public boolean getStatus() {
		return status;
	}
	public void setStatus(boolean status) {
		this.status = status;
	}
	@Override
	public String toString() {
		return GsonUtil.toJson(this, TokenResult.class);
	}
}
