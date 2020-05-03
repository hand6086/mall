package com.hand.core.util;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.nio.charset.Charset;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Set;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;

import com.hand.base.smscode.dao.mybatis.mapper.SystemConfigMapper;
import com.hand.base.smscode.model.MessageTemplate;
import com.hand.base.smscode.service.SmsService;
import com.hand.base.user.model.AppUser;
import com.hand.base.workbench.model.MesPush;
import com.hand.base.workbench.service.MesPushService;
import com.hand.cloopen.rest.sdk.CCPRestSDK;



public class SmsUtil {

	@Autowired
	private SystemConfigMapper configMapper;
	private static Logger logger = Logger.getLogger(SmsUtil.class);

	// public static boolean sendSms2(String phone, String content, String
	// infoId) {
	// String bodyXml = getSmsBody(phone, content, infoId);
	// logger.info(bodyXml);
	// HttpClient client = new DefaultHttpClient();
	// HttpPost post = new HttpPost(CommonConstant.getProKey("SMS_URL"));
	//
	// post.setHeader("Content-Type", "text/xml;charset=UTF-8");
	// post.setHeader("Connection", "Close");
	// try {
	// HttpEntity body = new StringEntity(bodyXml, Charset.forName("UTF-8"));
	// post.setEntity(body);
	// HttpResponse response = client.execute(post);
	// if (response.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {
	// InputStream is = response.getEntity().getContent();
	// //String resultBody = inStream2String(is);
	//
	// String result = parseResult(inStream2String(is));
	// logger.info("Send SMS result is " + result);
	// if (result == null) {
	// return false;
	// } else {
	// return result.contains("ok");
	// }
	// } else {
	// logger.warn("Status line for sending SMS is " +
	// response.getStatusLine());
	// return false;
	// }
	// } catch(Exception e) {
	// logger.error("Send SMS failed", e);
	// return false;
	// }
	// }
	/**
	 * 发送短信入口，此处区分 使用哪个平台
	 * 
	 * @param smsPlatform
	 *            平台
	 * @param smsContent
	 *            消息内容(E店宝使用)
	 * @param notifyType
	 *            模板类型
	 * @param tempAttr03
	 *            容联云的模板id（仅平台为容联云时使用）
	 * @param orderNumber
	 *            订单号
	 * @param merchantPhone
	 *            商户手机号码，如果有
	 * @param receiverPhone
	 *            接收方手机号码
	 * @param code
	 *            验证码
	 * @return
	 */
	public static boolean sendSms(String smsPlatform, String smsContent,
			String notifyType, String tempAttr03, String orderNumber,
			String merchantPhone, String receiverPhone, String code) {

		logger.debug("sendSms:" + smsContent + "  " + notifyType + "  "
				+ tempAttr03 + "  " + orderNumber + "  " + receiverPhone + "  "
				+ code);
		logger.debug("sendSms smsPlatform0:" + smsPlatform);
		if ("容联云".equals(smsPlatform)) {
			logger.debug("sendSms smsPlatform:容联云");
			// 容联云短信平台
			return sendSmsRLY(smsPlatform, smsContent, notifyType, tempAttr03,
					orderNumber, merchantPhone, receiverPhone, code);
		} else {
			// E店宝
			logger.debug("sendSms smsPlatform:E店宝");
			return SmsUtil.sendSmsByEDB(receiverPhone, smsContent, notifyType);
		}

	}

	public static boolean sendSmsRLY(String smsPlatform, String smsContent,
			String notifyType, String tempAttr03, String orderNumber,
			String merchantPhone, String receiverPhone, String code) {
		HashMap<String, Object> result = null;
		// #jinji#您好，编号为%s的订单已被取消，请停止配送。 取消订单
		// #jinji#您好，您本次的验证码为：%s。有效时间3分钟。 验证码
		// #jinji#您好，您编号为%s的订单已被抢单，商户电话：%s，验证码：%s，请在收货后将此验证码提供给商户，祝您购物愉快！ 商户接单
		// #jinji#您好，您编号为%s的订单已取消并已退款，欢迎您再次选购。 成功取消订单
		// #jinji#您有新的兜底订单，请及时接单并配送。

		try {

			String[] valuesArray = null;
			if ("取消订单".equals(notifyType)
					|| "取消订单".equals(notifyType)
					|| "成功取消订单"
							.equals(notifyType) || "拒绝取消订单".equals(notifyType)) {
				valuesArray = new String[1];
				valuesArray[0] = orderNumber;
			} else if ("验证码".equals(notifyType)
					||"注册验证码".equals(notifyType) ||"转账验证码".equals(notifyType)) {
				valuesArray = new String[1];
				valuesArray[0] = code;
			} else if ("商户接单".equals(notifyType)) {
				valuesArray = new String[3];
				valuesArray[0] = orderNumber;
				valuesArray[1] = merchantPhone;
				valuesArray[2] = code;

			} else if ( "兜底短信".equals(notifyType)) {
				valuesArray = new String[1];
				valuesArray[0] = orderNumber;
			}

			CCPRestSDK restAPI = new CCPRestSDK();
			restAPI.init("app.cloopen.com","8883");// 初始化服务器地址和端口，格式如下，服务器地址不需要写https://
			restAPI.setAccount("aaf98f895147cd2a01515622bcc4217c","7ca00fd632f44ac6a841e24f2d8c4877");// 初始化主帐号和主帐号TOKEN
			restAPI.setAppId("aaf98f895147cd2a01515c5af81d3534");// 初始化应用ID
			result = restAPI.sendTemplateSMS(receiverPhone, tempAttr03,
					valuesArray);

			logger.info("SDKTestSendTemplateSMS result=" + result);
			if ("000000".equals(result.get("statusCode"))) {
				// 正常返回输出data包体信息（map）
				HashMap<String, Object> data = (HashMap<String, Object>) result.get("data");
				Set<String> keySet = data.keySet();
				for (String key : keySet) {
					Object object = data.get(key);
					logger.info(key + " = " + object);
				}
				return true;
			} else {
				// 异常返回输出错误码和错误信息
				logger.info("错误码=" + result.get("statusCode") + " 错误信息= "
						+ result.get("statusMsg"));
				return false;
			}
		} catch (Exception e) {
			logger.error(e.getMessage());
				return false;
		}
	}

	public static boolean sendSmsByEDB(String phone, String content,
			String infoId) {
		String bodyXml = getSmsBody(phone, content, infoId);
		logger.info(bodyXml);

		HttpClientBuilder httpClientBuilder = HttpClientBuilder.create();
		// HttpClient
		CloseableHttpClient closeableHttpClient = httpClientBuilder.build();
		try {
			HttpPost post = new HttpPost("http://smscent.centaur.cn/jkSoap/soap");

			post.setHeader("Content-Type", "text/xml;charset=UTF-8");
			post.setHeader("Connection", "Close");
			HttpEntity body = new StringEntity(bodyXml,
					Charset.forName("UTF-8"));
			post.setEntity(body);
			RequestConfig requestConfig = RequestConfig.custom()
					.setSocketTimeout(20000)
					.setConnectTimeout(20000).build();
			post.setConfig(requestConfig);

			HttpResponse response = closeableHttpClient.execute(post);
			if (response.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {
				InputStream is = response.getEntity().getContent();
				// String resultBody = inStream2String(is);

				String result = parseResult(inStream2String(is));
				logger.info("Send SMS result is " + result);
				if (result == null) {
					return false;
				} else {
					return result.contains("ok");
				}
			} else {
				logger.warn("Status line for sending SMS is "
						+ response.getStatusLine());
				return false;
			}
		} catch (Exception e) {
			logger.error("Send SMS failed", e);
			return false;
		} finally {
			if (closeableHttpClient != null) {
				try {
					closeableHttpClient.close();
				} catch (Exception e) {
					logger.warn("close http client failed", e);
				}
			}
		}

	}

	private static String inStream2String(InputStream is) throws Exception {
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		byte[] buf = new byte[1024];
		int len = -1;
		while ((len = is.read(buf)) != -1) {
			baos.write(buf, 0, len);
		}
		return new String(baos.toByteArray());
	}

	private static String parseResult(String content) {
		if (StringUtils.isNull(content))
			return null;

		String returnStr = parseStr(content, "<return", "return>");
		if (returnStr == null)
			return null;

		return parseStr(returnStr, ">", "<");
	}

	private static String parseStr(String content, String startStr,
			String endStr) {
		int start = content.indexOf(startStr);
		if (start != -1) {
			int end = content.indexOf(endStr, start + startStr.length());
			if (end != -1) {
				return content.substring(start + startStr.length(), end);
			} else {
				return null;
			}
		} else {
			return null;
		}
	}

	private static String getSmsBody(String phone, String content, String infoId) {
		return "<soapenv:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:soap=\"http://smscent.centaur.cn/jkSoap/soap\">\n"
				+ "\t<soapenv:Header/>\n"
				+ "\t<soapenv:Body>\n"
				+ "\t\t<soap:SmsSend soapenv:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\">\n"
				+ "\t\t\t<user_name xsi:type=\"xsd:string\">"
				+ "edb_a74086"
				+ "</user_name>\n"
				+
				// 密码需要做两次MD5
				"\t\t\t<vcode xsi:type=\"xsd:string\">"
				+ UserPwdEncryption.md5(UserPwdEncryption.md5("since1903"))
				+ "</vcode>\n"
				+ "\t\t\t<content xsi:type=\"xsd:string\">"
				+ content
				+ "</content>\n"
				+ "\t\t\t<sign xsi:type=\"xsd:string\">"
				+ "青岛啤酒"
				+ "</sign>\n"
				+ "\t\t\t<mobiles xsi:type=\"xsd:string\">"
				+ phone
				+ "</mobiles>\n"
				+ "\t\t\t<info_ids xsi:type=\"xsd:string\">"
				+ infoId
				+ "</info_ids>\n"
				+ "\t\t\t<operateId xsi:type=\"xsd:string\"></operateId>\n"
				+ "\t\t</soap:SmsSend>\n"
				+ "\t</soapenv:Body>\n"
				+ "</soapenv:Envelope>";
	}

	
	public static void notifUser(AppUser user,String receiverPhone,MesPushService pdService,SmsService smsService,
			String notifyType, String orderId, String orderNumber,
			String merchantPhone, String code,String smsPlatform,String logisticsCompany,String logisticsOddNumber) {

		if (user == null) {
			return;
		}
		List<MessageTemplate> tempList = smsService.findTempByType(notifyType);
		boolean smsSent = false;
		boolean messagePushed = false;
		for (MessageTemplate temp : tempList) {
			if (!smsSent
					&& temp.getMsgType().equals("SMS")) {
				String smsContent = formatMessage(temp.getMsgContext(),
						temp.getType(), orderNumber, merchantPhone, code,logisticsCompany,logisticsOddNumber);
				SmsUtil.sendSms(smsPlatform,smsContent,notifyType,
						temp.gettAttr03(),orderNumber, merchantPhone,receiverPhone,code);
				
				smsSent = true;
			}

			if (!messagePushed
					&& temp.getMsgType().equals("MESSAGE")) {
				String pushContent = formatMessage(temp.getMsgContext(),
						temp.getType(), orderNumber, merchantPhone, code,logisticsCompany,logisticsOddNumber);
				MesPush pd = new MesPush();

				Date currentDate = new Date();
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				pd.setStartTime(formatter.format(currentDate));
				pd.setExpireTime(formatter.format(TimeTool.getExpireTime(60)));
				pd.setObjectId(orderId);
				pd.setObjectType("Customer".equals(user
						.getUserType()) ? "Customer"
						: "Merchant");
				pd.setIsPushed("N");
				pd.setPushText(pushContent);
				pd.setUserId(user.getCustomerId());
				pd.setActiveFlag("Y");
				try {
					pdService.insert(pd);
					messagePushed = true;
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}

	private static String formatMessage(String format, String type,
			String orderNumber, String phone, String checkCode,String logisticsCompany,String logisticsOddNumber) {
		if ("Order Pickup".equals(type)) {
			return String.format(format, orderNumber, phone, checkCode);
		} else if ("DSR Deliver".equals(type)) {
			return String.format(format, orderNumber, phone, checkCode);
		} else if ("Brand Order Delivery".equals(type)) {
			return String.format(format, orderNumber, logisticsCompany, logisticsOddNumber);
		} else {
			return String.format(format, orderNumber, checkCode);
		}
	}
}

