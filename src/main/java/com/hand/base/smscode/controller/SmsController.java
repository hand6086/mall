package com.hand.base.smscode.controller;

import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.OutputStream;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.imageio.ImageIO;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.hand.base.basic.service.BasicServiceException;
import com.hand.core.util.*;
import freemarker.template.utility.StringUtil;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hand.base.enterprise.model.Enterprise;
import com.hand.base.enterprise.service.EnterpriseService;
import com.hand.base.smscode.dao.mybatis.mapper.SystemConfigMapper;
import com.hand.base.smscode.model.MessageTemplate;
import com.hand.base.smscode.model.SmsLog;
import com.hand.base.smscode.service.SmsService;
import redis.clients.jedis.Jedis;
//import com.tsingtao.o2o.model.base.RestResp;
//import com.tsingtao.o2o.utils.CommonConstant;
//import com.tsingtao.o2o.utils.CommonUtil;

@Controller
@RequestMapping("/action/portal/sms")
public class SmsController {

	private static final Logger LOGGER = Logger.getLogger(SmsController.class);

	@Autowired
	private SmsService smsService;
	@Autowired
	private SystemConfigMapper configMapper;
	@Autowired
	private EnterpriseService enterpriseService;
	/**
	 * 获取注册验证码
	 * @param request
	 * @param servletRequest
	 * @return
	 */
	@RequestMapping(value = "/getCode", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getCode(ServletRequest request, HttpServletRequest servletRequest) {
		Map<String, Object> result = new HashMap<String, Object>();
		String phone = request.getParameter("contactPhone");
		Date currentDate = new Date();
		// 用户名是否合法
		if (checkPhoneNumFormat(phone)) {
			SmsLog sms = smsService.getPinByPhone(phone);
			String smsPlatform = configMapper.getSMSPlatformByCode("TB_O2O_SMS_Platform_Change");
			List<MessageTemplate> tempList = smsService.findTempByType("Check Code");
			if (sms == null) {
				String code = GetCode.getcode();

				boolean sended = false;
				if (tempList != null && tempList.size() > 0) {
					MessageTemplate template = tempList.get(0);
					sended = SmsUtil.sendSms(smsPlatform, String.format(template.getMsgContext(), code), "注册验证码",
							template.gettAttr03(), null, null, phone, code);
				} else {
					LOGGER.info("执行到此处说明模板表里面缺少 验证码   类型的模板");
				}

				if (!sended) {
					LOGGER.info("服务器异常，请稍后重试");
					result.put("success", false);
					result.put("result", "服务器异常，请稍后重试！");
				} else {
					LOGGER.info("验证码发送成功！");
					result.put("success", true);
					result.put("result", "验证码发送成功！");
				}

				// 语音验证码
				String yuyin = GetCode.getcode();
				while (yuyin.equals(code)) {
					yuyin = GetCode.getcode();
				}
				yuyin = yuyin.replaceAll("0", "2");
				sms = new SmsLog();
				sms.setContext(code);
				sms.settAttr01(yuyin);
				sms.setCreated(currentDate);
				sms.setCreatedBy(phone);
				sms.setDbLastUpd(currentDate);
				sms.setDbLastUpdSrc("APP");
				sms.setExpireTime(TimeTool.getExpireTime(TimeTool.THIRTY_MINUTES));
				sms.setLastUpd(currentDate);
				sms.setLastUpdBy(phone);
				sms.setType("注册验证码");
				sms.setTargetPhone(phone);
				smsService.insert(sms);
			} else {
				// check the time
				if ((currentDate.getTime() - sms.getLastUpd().getTime() < 60 * 1000)) {
					LOGGER.info("一分钟内禁止重复发送验证码！");
					result.put("success", false);
					result.put("result", "一分钟内禁止重复发送验证码！");
				} else {
					String code = GetCode.getcode();

					boolean sended = false;
					if (tempList != null && tempList.size() > 0) {
						MessageTemplate template = tempList.get(0);
						sended = SmsUtil.sendSms(smsPlatform, String.format(template.getMsgContext(), code), "注册验证码",
								template.gettAttr03(), null, null, phone, code);
					} else {
						LOGGER.debug("执行到此处说明模板表里面缺少 验证码   类型的模板");
						result.put("success", false);
						result.put("result", "缺少模板！");
					}

					if (!sended) {
						LOGGER.info("服务器异常，请稍后重试");
						result.put("success", false);
						result.put("result", "服务器异常，请稍后重试！");
					} else {
						LOGGER.info("验证码发送成功！");
						result.put("success", true);
						result.put("result", "验证码发送成功！");

					}

					// update the code
					String yuyin = GetCode.getcode();
					while (yuyin.equals(code)) {
						yuyin = GetCode.getcode();
					}
					yuyin = yuyin.replaceAll("0", "2");
					sms.settAttr01(yuyin);
					sms.setDbLastUpd(currentDate);
					sms.setExpireTime(TimeTool.getExpireTime(TimeTool.THIRTY_MINUTES));
					sms.setLastUpd(currentDate);
					sms.setModificationNum(sms.getModificationNum() + 1);
					sms.setContext(code);
					smsService.update(sms);

				}
			}
		} else {
			LOGGER.info("参数值非法" + phone);
			result.put("success", false);
			result.put("result", "参数值非法");
		}
		return result;
	}
	
	@RequestMapping(value = "/getTransferCode", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getTransferCode(	Enterprise enterprise,ServletRequest request, HttpServletRequest servletRequest) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
	
		//Date currentDate = new Date();
		enterprise = enterpriseService.queryById(enterprise);	
		String phone =enterprise.getApplicantPhone();
		String smsPlatform = configMapper.getSMSPlatformByCode("TB_O2O_SMS_Platform_Change");
		List<MessageTemplate> tempList = smsService.findTempByType("Transfer Check Code");
		if(enterprise.getTransferCode()==null || "".equals(enterprise.getTransferCode())){

			String code = CodeUtil.getTransferCode();
			code = code.substring(0, 4);
			
			boolean sended = false;
			if (tempList != null && tempList.size() > 0) {
				MessageTemplate template = tempList.get(0);
				sended = SmsUtil.sendSms(smsPlatform, String.format(template.getMsgContext(), code), "转账验证码",
						template.gettAttr03(), null, null, phone, code);
			} else {
				LOGGER.info("执行到此处说明模板表里面缺少 验证码   类型的模板");
			}

			if (!sended) {
				LOGGER.info("服务器异常，请稍后重试");
				result.put("success", false);
				result.put("result", "服务器异常，请稍后重试！");
			} else {
				LOGGER.info("验证码发送成功！");
				result.put("success", true);
				result.put("result", "验证码发送成功！");
			}
			enterprise.setTransferCode(code);
			enterpriseService.transferCodeUpdate(enterprise);
		}else{
			result.put("success", false);
			result.put("result",enterprise.getTransferCode());
		}
//		else{
//			// check the time
//			if ((currentDate.getTime() - sms.getLastUpd().getTime() < 60 * 1000)) {
//				LOGGER.info("一分钟内禁止重复发送验证码！");
//				result.put("success", false);
//				result.put("result", "一分钟内禁止重复发送验证码！");
//			}
//			
//			else {
//				String code = GetCode.getcode();
//
//				boolean sended = false;
//				if (tempList != null && tempList.size() > 0) {
//					MessageTemplate template = tempList.get(0);
//					sended = SmsUtil.sendSms(smsPlatform, String.format(template.getMsgContext(), code), "转账验证码",
//							template.gettAttr03(), null, null, phone, code);
//				} else {
//					LOGGER.debug("执行到此处说明模板表里面缺少 验证码   类型的模板");
//					result.put("success", false);
//					result.put("result", "缺少模板！");
//				}
//
//				if (!sended) {
//					LOGGER.info("服务器异常，请稍后重试");
//					result.put("success", false);
//					result.put("result", "服务器异常，请稍后重试！");
//				} else {
//					LOGGER.info("验证码发送成功！");
//					result.put("success", true);
//					result.put("result", "验证码发送成功！");
//
//				}
//
//				
//				sms.settAttr01("");
//				sms.setDbLastUpd(currentDate);
//				sms.setExpireTime(TimeTool.getExpireTime(TimeTool.THIRTY_MINUTES));
//				sms.setLastUpd(currentDate);
//				sms.setModificationNum(sms.getModificationNum() + 1);
//				sms.setContext(code);
//				smsService.update(sms);
//
//			}
//		
//		}
		return result;
	}
	

	/**
	 * 验证码是否正确
	 * @param request
	 * @param servletRequest
	 * @return
	 */
	@RequestMapping(value = "/verifyCode", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> verifyCode(ServletRequest request, HttpServletRequest servletRequest) {
		Map<String, Object> result = new HashMap<String, Object>();

		String phone = request.getParameter("contactPhone");
		String code = request.getParameter("VerifyCode");
		// 手机号是否合法
		if (checkPhoneNumFormat(phone)) {
			checkSmsCode(smsService, phone, code, result);
		} else {
			LOGGER.info("参数值非法" + phone);
			result.put("success", false);
		}
		return result;
	}

	/**
	 * 验证码是否正确,重置密码界面
	 * @param request
	 * @param servletRequest
	 * @return
	 */
	@RequestMapping(value = "/resetPwdVerifyCode", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> resetPwdVerifyCode(ServletRequest request, HttpServletRequest servletRequest) {
		Map<String, Object> result = new HashMap<String, Object>();

		String phone = request.getParameter("contactPhone");
		String userName = request.getParameter("username");
		String code = request.getParameter("VerifyCode");
		if (StringUtils.isBlank(phone) || StringUtils.isBlank(userName)) {
			throw new BasicServiceException("手机号或用户名为空！");
		}

		Jedis jedis = null;
		try {
			jedis = RedisUtil.getJedis();
			String userKey = "reset_pwd_user_" + userName;
			String value = userName.toUpperCase() + phone;
			String jedisVal = jedis.get(userKey);
			if (StringUtils.isBlank(jedisVal)){
				result.put("success", false);
				result.put("result", "验证码错误!");
			}
			// 检测用户名与手机号与前一步校验的用户名手机号是否相同，防止用户信息被篡改
			if (value.equals(jedisVal)) {
				// 手机号是否合法
				if (checkPhoneNumFormat(phone)) {
					resetPwdCheckSmsCode(smsService, phone, code, result);
				} else {
					LOGGER.info("参数值非法" + phone);
					result.put("success", false);
				}
			} else {
				result.put("success", false);
				result.put("result", "验证码错误!");
			}
		}catch (BasicServiceException e){
			result.put("success", false);
			result.put("result", "验证码错误!");
		}finally {
			RedisUtil.returnResource(jedis);
		}

		return result;
	}

	
	/**
	 * 验证码校验方法
	 * @param smsService
	 * @param phone
	 * @param smsCode
	 * @param result
	 * @return
	 */
	protected Map<String, Object> checkSmsCode(SmsService smsService, String phone, String smsCode,
			Map<String, Object> result) {
		SmsLog sms = smsService.getPinByPhone(phone);
		if (sms == null || !sms.getContext().equals(smsCode)) {
			LOGGER.info("验证码错误");
			result.put("success", false);
			return result;
		}

		Date currentTime = new Date();

		if (currentTime.getTime() - sms.getLastUpd().getTime() > 60 * 1000 * 3) {
			LOGGER.info("验证码" + smsCode + "已过期");
			result.put("success", false);
			result.put("result", "验证码" + smsCode + "已过期");
			return result;
		}
		LOGGER.info("验证成功");
		result.put("success", true);

		return result;
	}

	/**
	 * 重置密码界面的验证码校验
	 * @param smsService
	 * @param phone
	 * @param smsCode
	 * @param result
	 * @return
	 */
	protected Map<String, Object> resetPwdCheckSmsCode(SmsService smsService, String phone, String smsCode,
											   Map<String, Object> result) {
		Jedis jedis = null;
		try {
			// 将成功的校验结果存入缓存
			jedis = RedisUtil.getJedis();
			String key = "verify_code_" + phone;

			SmsLog sms = smsService.getPinByPhone(phone);
			if (sms == null || !sms.getContext().equals(smsCode)) {
				LOGGER.info("验证码错误");
				result.put("success", false);
				return result;
			}

			Date currentTime = new Date();

			if (currentTime.getTime() - sms.getLastUpd().getTime() > 60 * 1000 * 3) {
				LOGGER.info("验证码" + smsCode + "已过期");
				result.put("success", false);
				result.put("result", "验证码" + smsCode + "已过期");
				return result;
			}
			LOGGER.info("验证成功");
			jedis.set(key,"SUCCESS");
			// 设置有效时间10分钟
			jedis.expire(key, 600);
			result.put("success", true);
		}catch (BasicServiceException e){
			result.put("success", false);
			result.put("result", "验证码错误!");
		}finally {
			RedisUtil.returnResource(jedis);
		}
		return result;
	}

	/**
	 * 手机号格式校验
	 * @param phoneNum
	 * @return
	 */
	public static boolean checkPhoneNumFormat(String phoneNum) {
		Pattern p = Pattern.compile("^(1[3-8][0-9])\\d{8}$");
		Matcher m = p.matcher(phoneNum);
		return m.matches();
	}

	//生成验证码图片  
	@RequestMapping(value = "/valicode", method = RequestMethod.POST)
    @ResponseBody
	public Map<String, Object> valicode(HttpServletResponse response,HttpSession session) throws Exception{
        Map<String, Object> result = new HashMap<String, Object>();
	    //第一个参数是生成的验证码，第二个参数是生成的图片  
	    Object[] objs = ImageCodeUtils.createImage();
	    //将验证码存入Session  
	    session.setAttribute("imageCode",objs[0]);  
	    //将图片输出给浏览器  
	    BufferedImage image = (BufferedImage) objs[1];  
	    /*response.setContentType("image/png");
	    OutputStream os = response.getOutputStream();  
	    ImageIO.write(image, "png", os); */
        ByteArrayOutputStream bs = new ByteArrayOutputStream();
        ImageIO.write(image, "png", bs);//将绘制得图片输出到流
        String imgsrc = com.alibaba.druid.util.Base64.byteArrayToBase64(bs.toByteArray());
        result.put("imgsrc", imgsrc);
        result.put("code", StringUtils.md5(objs[0].toString().toLowerCase()));
        return result;
	}

	// 校验码校验
	@RequestMapping(value = "/checkValicode", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> checkValicode( HttpServletRequest servletRequest, HttpServletResponse response,HttpSession session) throws Exception{  
		Map<String, Object> result = new HashMap<String, Object>();
		try{   
			String code = servletRequest.getParameter("code");
			String imageCode = session.getAttribute("imageCode").toString();
			if( code != null && code.equalsIgnoreCase(imageCode) ){
				result.put("success", true);
			} else{
				result.put("success", false);
			}
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
}
