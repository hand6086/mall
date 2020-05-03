package com.hand.base.email.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.hand.base.common.model.Attachment;
import com.hand.base.common.service.AttachmentService;
import com.hand.base.email.emailUtils.SendMail;
import com.hand.base.email.model.EmailInfomation;
import com.hand.base.email.service.EInfomationService;
import com.hand.base.user.model.User;
import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.controller.BasicControllerException;
import com.hand.core.basic.query.Filter;
import com.hand.core.basic.query.QueryParams;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.basic.service.KeyGenerateService;
import com.hand.core.util.AppConstants;
import com.hand.core.util.Constants;
import com.hand.core.util.FileUtil;
import com.hand.core.util.StringUtils;
import com.hand.core.util.UserUtil;

@Controller
@RequestMapping("/action/portal/emailInfo")
public class PortalEInfomationController extends BasicController<EmailInfomation>{
	private static final Logger logger = LogManager.getLogger(PortalEInfomationController.class);
	
	@Resource
	private AttachmentService attachmentService;
	@Resource
	private EInfomationService eInfomationService;
	@Resource
	private KeyGenerateService keyGenerateService;
	@Override
	public BasicService<EmailInfomation>  getBasicService() throws Exception{
		return eInfomationService;
	}
	
	@RequestMapping(value = "/uploadEmailAtt", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public Map<String, Object> uploadEmailAtt(EmailInfomation record, HttpSession session, HttpServletRequest request, HttpServletResponse response){
		Map<String, Object> result = new HashMap<String, Object>();
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request; 
		List<MultipartFile> myfiles=multipartRequest.getFiles("myfiles");
		if(!FileUtil.validateIsAllImage(myfiles)){
			throw new BasicControllerException("上上传图片格式错误！");
		}
		try{
			// 插入附件表
			logger.debug(Constants.LOG_DIVISION_LINE + "attachment insert start!");
			List<Attachment> list = attachmentService.emailAttachmentUpload(myfiles);// 附件上传，返回一个附件对象的列表
			Attachment att = list.get(0);
			result.put("success", true);
			result.put("imgFileName", att.getAttachmentName());
			result.put("result", "主题为：" + record.getEmailTitle() + "的邮件的附件已经保存成功！");
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", "主题为：" + record.getEmailTitle() + "的邮件的附件已经保存成功！");
		}
		return result;
	}
	
	@RequestMapping(value = "/delEmailAtt", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> delEmailAtt(HttpSession session, HttpServletRequest request, HttpServletResponse response){
		Map<String, Object> result = new HashMap<String, Object>();
		String fileName = request.getParameter("fileName");
		try{
			//删除邮件附件
			logger.debug(Constants.LOG_DIVISION_LINE + "attachment delete start!");
			attachmentService.emailAttachmentDelete(fileName);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value = "/downloadEmailAtt/{fileName}",method = RequestMethod.GET)
	public void downloadEmailAtt(@PathVariable("fileName") String fileName,HttpSession session, HttpServletRequest request, HttpServletResponse response){
		String extName = request.getParameter("extName");
		if(!StringUtils.isNull(fileName))
		{	
			String fileFullName = fileName+"."+extName;
			try {
				attachmentService.emailAttachmentDownload(fileFullName, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	@RequestMapping(value = "/sendEmail", method = RequestMethod.POST,produces = "application/json")
	@ResponseBody
	public Map<String, Object> sendEmail(EmailInfomation record, HttpSession session, HttpServletRequest request, HttpServletResponse response){
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String,String> map=new HashMap<String,String>();
		
		try{
			map.put("smtp", "smtp.sina.cn");
			//邮件传输协议：如smtp
			map.put("protocol", "smtp");
			
			//登录邮箱的用户名
			map.put("username", "linkcrm@sina.com");
			//登录邮箱的密码
			map.put("password", "handhand");
			
			//发送人的帐号
			//map.put("from", "linkcrm@sina.com");
			String emailSendAddr = record.getEmailSendAddr();
			map.put("from",emailSendAddr);
			
			//接收人的帐号，多个以","号隔开
			//map.put("to", "18288748779@139.com");
			String emailReceiveAddr = record.getEmailReceiveAddr();
			//emailReceiveAddr = "18288748779@139.com;973367148@qq.com";
			map.put("to", emailReceiveAddr);
			//邮件抄送人
			map.put("toCc",record.getEmailCcAddr());
			//邮件密送人
			map.put("toBCc",record.getEmailBCcAddr());
			//邮件主题
			map.put("subject", record.getEmailTitle());
			//邮件内容
			map.put("body", record.getEmailMsg());
			
			//内嵌了多少张图片，如果没有，则new一个不带值的Map
			Map<String,String> image=new HashMap<String,String>();
			String path = request.getRealPath("/image");
			String innerImgStr = record.getInnerImgSrc();
			if(StringUtils.isNotBlank(innerImgStr)){
				String[] innerImgArr = innerImgStr.split("\\|");
				for(int i=1;i<= innerImgArr.length;i++){
					String innerImg = innerImgArr[i-1];
					String imgFileName = path+"/"+innerImg.substring(innerImg.lastIndexOf("/"));
					image.put("a0000000"+i,imgFileName);
			    }
			}
			
			//附件的绝对路径,不发附件则new一个不带值的List
			List<String> list=new ArrayList<String>();
			String emailAtt = record.getEmailAtt();
			User user = UserUtil.getUser(null);
			String realativPath = "/file/" + user.getId() + "/" + "emailTemp";
			String realPath = AppConstants.portalShareFileDir + realativPath;
			if(emailAtt != null && !"".equals(emailAtt)){
				String[] filesName = emailAtt.split("\\|");
				for(String fileName : filesName){
					list.add(realPath+"/"+fileName);
				}
			}
			
			//创建实例
			SendMail sm=new SendMail(map,list,image);
			//SendMail sm=new SendMail(map,list);
			//执行发送
			sm.send();
			
			result.put("success", true);
			result.put("result", "主题为：" + record.getEmailTitle() + "的邮件的附件已经保存成功！");
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
}
