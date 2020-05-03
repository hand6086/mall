package com.hand.core.util;

import org.apache.commons.mail.DefaultAuthenticator;
import org.apache.commons.mail.HtmlEmail;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;


public class EmailUtil {
	private static final Logger logger = LogManager.getLogger(EmailUtil.class);
	
	/**
	 * 
	 * @param emailReceiveAddr
	 * @param emailMsg
	 * @param emailTitle
	 * @return 是否发送成功
	 */
	public static boolean sendEmail(String emailReceiveAddr, String emailMsg, String emailTitle){
		boolean flag = true;
		try{
			//1、校验信息
			if(StringUtils.isBlank(emailReceiveAddr)){
				throw new Exception("收件地址不能为空！");
			}
			if(StringUtils.isBlank(emailMsg)){
				throw new Exception("邮件内容不能为空！");
			}
			if(StringUtils.isBlank(emailTitle)){
				throw new Exception("邮件标题不能为空！");
			}
			//2、开始发送
			String htmlEmailTemplate = emailMsg;
			HtmlEmail email = new HtmlEmail();
			email.setHostName("smtp.sina.com");
			email.setSmtpPort(465);
			email.setCharset("UTF-8");
			email.setAuthenticator(new DefaultAuthenticator("linkcrm", "handhand"));
			email.setSSLOnConnect(true);
			email.setFrom("linkcrm@sina.com","Link CRM");
			email.setSubject(emailTitle);
			email.setHtmlMsg(htmlEmailTemplate);
			email.addTo(emailReceiveAddr);
			email.send();
		}catch(Exception e){
			e.printStackTrace();
			flag = false;
		}
		return flag;
	}
}
