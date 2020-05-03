package com.hand.base.user.login;

public class HandTempPass {
	private String passwd;			//密码
	private Long remenberedTime;	//缓存时间点
	
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public Long getRemenberedTime() {
		return remenberedTime;
	}
	public void setRemenberedTime(Long remenberedTime) {
		this.remenberedTime = remenberedTime;
	}
	
}
