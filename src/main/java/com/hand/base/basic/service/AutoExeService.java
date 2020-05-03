package com.hand.base.basic.service;

import java.io.IOException;

import javax.annotation.PostConstruct;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;

import com.hand.core.util.AppConstants;

@Configuration
public class AutoExeService {

	private static final Logger logger = LogManager.getLogger(AutoExeService.class);

	@Autowired
	private Environment env;

	@PostConstruct
	private void init() throws Exception {
		loadCfgFromProperties();
	}

	/**
	 * 
	 * <p>
	 * 从配置文件中加载参数
	 * </p>
	 * 
	 * @author yrf
	 * @throws IOException
	 */
	private void loadCfgFromProperties() throws IOException {
		/*
		 * 默认Portal文件系统URL根目录
		 */
		AppConstants.portalShareUrlDir = env.getProperty("application.uploadfile.portal.httpshare");
		
		/**
		 * 访问静态文件url
		 */
		AppConstants.portalStaticUrl = env.getProperty("application.static.url");
		/*
		 * 默认Portal文件系统根目录
		 */
		AppConstants.portalShareFileDir = env.getProperty("application.uploadfile.portal.share");
		/*
		 * 默认导入导出临时URL根目录
		 */
		AppConstants.temporaryIOUrlDir = env.getProperty("application.io.temporary.httpshare");
		/*
		 * 默认导入导出文件系统根目录
		 */
		AppConstants.temporaryIOFileDir = env.getProperty("application.io.temporary.share");
		AppConstants.portalSharePicDir = env.getProperty("application.uploadfile.pic.share");// 上传图片路径
		AppConstants.portalSharePicHttpDir = env.getProperty("application.uploadfile.pic.httpshare");// 上传图片服务器路径
		AppConstants.portalUserRefundUrl = env.getProperty("application.user.refund.url");// 订单退款接口路径
		AppConstants.key_applicationRedisHost = env.getProperty("spring.redis.host");// "application.redis.hostname";
		AppConstants.key_applicationRedisPort = env.getProperty("spring.redis.port");// "application.redis.port";
		// 数据库配置
		AppConstants.key_applicationDatabase = env.getProperty("application.database");// "mysql";//"application.database";
		
		AppConstants.appQrCodeImg = env.getProperty("application.app.img");// 下载AndroidAPP的二维码图片名称
		
		AppConstants.appKey = env.getProperty("application.app.appKey");// 融云 appkey
		
		AppConstants.appSecret = env.getProperty("application.app.appSecret");// 融云 appSecret
		
		AppConstants.docAppUrl = env.getProperty("application.doc.url.path");
		
		AppConstants.portalTaskDefaultRun = env.getProperty("application.task.defaultRun");// 是否运行定时任务
	}
}
