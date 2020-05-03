package com.hand.core.util;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;

/**
 * 主程序常量
 * 
 * @author Ashen、Leon
 * 		
 */
public class AppConstants {
	// ISO 推送证书地址
	public static String pushIosBookLocation;
	// ISO 推送密码
	public static String pushIosPassword;
	// ISO 推送APPLE正式环境
	public static boolean pushIosProduction;
	// Android推送AppKey
	public static String pushAndroidAppKey;
	// Android推送AppId
	public static String pushAndroidAppId;
	// Android推送Master
	public static String pushAndroidMaster;
	public static String APP_DATE_FORMATE		= "yyyy-MM-dd";							// 默认日期格式
	public static String APP_DATETIME_FORMATE	= "yyyy-MM-dd HH:mm:ss";				// 默认时间格式
	public static String APP_NUMBER_FORMATE		= "0";									// 默认整数字
	public static String APP_DECIMAL_FORMATE		= "0.##";								// 默认浮点数字
	public static String APP_ENCODING			= "UTF-8";								// 默认编码
	public static String APP_EXPORT_ENCODING		= "GB18030";							// 导出文件编码
	public static String appShareUrlDir;													// 默认App文件系统URL根目录
	public static String appShareFileDir;												// 默认App文件系统根目录
	
	// siebel WebService 参数
	public static String siebelWebserviceUsername;
	public static String siebelWebservicePassword;
	
	/*
	 * 默认Portal文件系统URL根目录
	 */
	public static String portalShareUrlDir;
	
	/**
	 * 访问静态文件url
	 */
	public static String portalStaticUrl;
	/*
	 * 默认Portal文件系统根目录
	 */
	public static String portalShareFileDir;
	/*
	 * 默认导入导出临时URL根目录
	 */
	public static String temporaryIOUrlDir;
	/*
	 * 默认导入导出文件系统根目录
	 */
	public static String temporaryIOFileDir;
	public static String portalSharePicDir;
	public static String portalSharePicHttpDir;
	public static String portalUserRefundUrl;
	public static String key_applicationRedisHost;
	public static String key_applicationRedisPort;
	
	//是否运行定时任务
	public static String portalTaskDefaultRun;
	
	// 数据库配置
	public static String key_applicationDatabase;
	
	//cmq信息(消息队列)
    public static String cmqSecretKey = "cmq.secret.key";
    public static String cmqSecretId = "cmq.secret.id";
    public static String cmqQueueEndpoint = "cmq.queue.endpoint";
    
	/**
	 * 格式化类
	 */
	// 主程序整数格式器
	public static DecimalFormat	numberFormatter = new DecimalFormat(AppConstants.APP_NUMBER_FORMATE);
	// 主程序浮点数字格式器
	public static DecimalFormat	decimalFormatter = new DecimalFormat(AppConstants.APP_DECIMAL_FORMATE);
	// 主程序日期格式器
	public static SimpleDateFormat	dateFormatter = new SimpleDateFormat(AppConstants.APP_DATE_FORMATE);
	// 主程序时间格式器
	public static SimpleDateFormat	datetimeFormatter = new SimpleDateFormat(AppConstants.APP_DATETIME_FORMATE);
	
	/** 企点 集成商appid */
	public static String qdCrmApiUrlPrefix; /*企点api应用服务器的url前缀 */
	public static String outerUserDefaultRole;	/* 外部用户默认角色 */
	public static String outerUserDefaultDuty ;/* 外部用户默认职责 （id) */
	public static String outerUserDefaultPostn ;/* 外部用户默认职位 （id) */
	
	public static String docAppUrl; /*对外接口路径 */
	
	/**
	 * 严格访问控制URL模式在redis下的KEY
	 */
	public static final String LINKCRM_RESTRICT_ACCESS_URL = "LINKCRM_RESTRICT_ACCESS_URL";
	
	/**
	 * +用户ID，表示用不可访问URL在redis中的key
	 */
	public static final String LINKCRM_DISABLE_ACCESS_URL_USER = "DISABLE_ACCESS_URL_USER_";
	
	/**
	 * 系统公共参数在redis中的KEY
	 */
	public final static String SYS_PROPERTY_COMMON_KEY = "APPLICATION_PARM_ALL";
	
	/**
	 * +corpId，表示公司私有参数在redis中的KEY
	 */
	public final static String SYS_PROPERTY_CORP_KEY = "APPLICATION_PARM_";
	/**
	 * 物流接口返回标志
	 */
	public static String logistics_success = "success";
	/**
	 * 物流接口返回信息
	 */
	public static String logistics_result = "result";
	
	public static void setPushIosProduction(String str) {
		if (str != null && (str.equals("true") || str.equals("TRUE"))) {
			AppConstants.pushIosProduction = true;
		} else {
			AppConstants.pushIosProduction = false;
		}
	}
	
	/**
	 * 接口返回状态：成功
	 */
	public static String INTERFACE_QUERY_SUCCESS_STATUS = "SUCCESS";
	
	/**
	 * 接口返回状态：失败
	 */
	public static String INTERFACE_QUERY_ERROR_STATUS = "ERROR";
	
	/**
	 * 接口：调用成功编码
	 */
	public static String INTERFACE_QUERY_SUCCESS_CODE = "100";
	
	/**
	 * 接口：调用参数错误编码
	 */
	public static String INTERFACE_QUERY_PARAM_ERROR_CODE = "101";
	
	/**
	 * 接口：账号不存在错误编码
	 */
	public static String INTERFACE_QUERY_USERNAME_ERROR_CODE = "102";
	
	/**
	 * 接口：密码校验失败编码
	 */
	public static String INTERFACE_QUERY_PASSWORD_ERROR_CODE = "103";
	
	/**
	 * 接口：企业编码错误
	 */
	public static String INTERFACE_QUERY_ENTERPRICE_ERROR_CODE = "104";
	
	/**
	 * 接口：Token失效
	 */
	public static String INTERFACE_QUERY_TOKEN_ERROR_CODE = "105";
	
	/**
	 * 接口：参数错误
	 */
	public static String INTERFACE_QUERY_PARAMS_ERROR_CODE = "110";
	
	
	/**
	 * 接口：其他错误
	 */
	public static String INTERFACE_QUERY_OTHER_ERROR_CODE = "120";
}
