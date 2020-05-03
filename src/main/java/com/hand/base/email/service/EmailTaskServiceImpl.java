package com.hand.base.email.service;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.mail.DefaultAuthenticator;
import org.apache.commons.mail.HtmlEmail;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.hand.base.email.model.EmailInfo;
import com.hand.base.email.model.EmailItem;
import com.hand.base.basic.model.BasicModel;
import com.hand.core.basic.query.Filter;
import com.hand.core.basic.query.QueryParams;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.core.util.DateUtil;

@Service
@Repository(value = "emailTaskService")
public class EmailTaskServiceImpl{
	
	@Resource
	private EmailService emailService;
	
	@Resource
	private EmailItemService emailItemService;

	private static final Logger logger = LogManager.getLogger(EmailTaskServiceImpl.class);
	
	public void sendEmailTask(){
		try {
			int size = 0,successSize = 0;
			QueryParams qps = new QueryParams();
			qps.addFilter(new Filter("status","待发送"));
			qps.addFilter(new Filter("sendTime",Filter.OP_LESS_EQUAL,DateUtil.getYY_MM_DDHHmmss(new Date())));
			qps.setUsercorpid("102");
			EmailInfo entity = (EmailInfo)BasicModel.transformClass(EmailInfo.class, qps);
			entity.setPageFlag(false);
			List<EmailInfo> list = emailService.queryByExamplePage(entity);
			if(list == null || list.size() == 0){
				return;
			}
			size = list.size();
			logger.info("邮件发送任务开始:总共有["+size+"]封邮件需要发送...");
			for(int i = 0;i<size;i++){
				if(sendEmailInfo(list.get(i)))
				{
					successSize++;
				}
			}
			logger.info("邮件发送任务开始:总共有["+size+"]封邮件需要发送,成功发送["+successSize+"],发送失败["+(size-successSize)+"]");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private boolean sendEmailInfo(EmailInfo emailInfo){
		boolean flag = true;
		try{
			//1、校验发送的内容
			if(emailInfo.getEmailTitle() == null || "".equals(emailInfo.getEmailTitle())){
				throw new BasicServiceException("邮件标题不能为空！");
			}
			if(emailInfo.getEmailMsg() == null || "".equals(emailInfo.getEmailMsg())){
				throw new BasicServiceException("邮件内容不能为空！");
			}
			if(emailInfo.getId() == null || "".equals(emailInfo.getId())){
				throw new BasicServiceException("邮件ID不能为空！");
			}
			QueryParams qps = new QueryParams();
			qps.setUsercorpid("102");
			qps.addFilter(new Filter("emailId",emailInfo.getId()));
			EmailItem entity = (EmailItem)BasicModel.transformClass(EmailItem.class, qps);
			entity.setPageFlag(false);
			List<EmailItem> itemList = emailItemService.queryByExamplePage(entity);
			if(itemList == null || itemList.size() == 0){
				throw new BasicServiceException("邮件收件人列表！");
			}

			//2、标志正在发送状态
			//系统用户为匿名用户更新操作
			emailInfo.setUsercorpid("102");
			emailInfo.setAnonymousFlag("Y");
			emailInfo.setStatus("正在发送");
			emailService.update(emailInfo);
			
			//3、开始发送具体信息
			int sendedSize = 0;
			for(int i=0;i<itemList.size();i++){
				if(sendEmailItem(itemList.get(i),emailInfo.getEmailMsg(),emailInfo.getEmailTitle())){
					sendedSize++;
				}
			}
			
			//
			if(sendedSize == itemList.size()){
				emailInfo.setStatus("发送成功");
				emailService.update(emailInfo);
			}else if(sendedSize == 0){
				emailInfo.setStatus("发送失败");
				emailService.update(emailInfo);
			}else{
				emailInfo.setStatus("部分失败");
				emailService.update(emailInfo);
			}
			
		}catch(Exception e){
			e.printStackTrace();
			emailInfo.setStatus("发送失败");
			try {
				emailService.update(emailInfo);
			} catch (Exception e1) {
				e1.printStackTrace();
			}
			flag = false;
		}
		return flag;
	}

	public boolean sendEmailItem(EmailItem emailItem, String emailMsg, String emailTitle) {
		boolean flag = true;
		try{
			//1、校验信息
			if(emailItem.getEmailReceiveAddr() == null || "".equals(emailItem.getEmailReceiveAddr())){
				throw new BasicServiceException("收件地址不能为空！");
			}
			//2、设置发送标志
			emailItem.setAnonymousFlag("Y");
			emailItem.setUsercorpid("102");
			emailItem.setStatus("正在发送");
			emailItemService.update(emailItem);
			
			//3、开始发送
			String htmlEmailTemplate = emailMsg+"</br><img src=\"http://vs156.hand-china.com:7777/static/css/img/login_07.png\"> Closer Customer Relationship";
			HtmlEmail email = new HtmlEmail();
			email.setHostName("smtp.sina.com");
			email.setSmtpPort(465);
			email.setCharset("UTF-8");
			email.setAuthenticator(new DefaultAuthenticator("linkcrm", "handhand"));
			email.setSSLOnConnect(true);
			email.setFrom("linkcrm@sina.com","Link CRM");
			email.setSubject(emailTitle);
			email.setHtmlMsg(htmlEmailTemplate);
			email.addTo(emailItem.getEmailReceiveAddr(), emailItem.getEmailReceiveName());
			email.send();
			//4、发送成功
			emailItem.setStatus("发送成功");
			emailItem.setErrorMsg("");
			emailItemService.update(emailItem);
		}catch(Exception e){
			e.printStackTrace();
			flag = false;
			//5、发送失败
			try {
				emailItem.setStatus("发送失败");
				emailItem.setErrorMsg(e.getMessage());
				emailItemService.update(emailItem);
			} catch (Exception e1) {
				e1.printStackTrace();
			}
		}
		return flag;
	}
}
