package com.hand.core.basic.listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.hand.core.util.AppConstants;

public class ApplicationConfigListener implements ServletContextListener {
	private static final Logger logger = LogManager.getLogger(ApplicationConfigListener.class);
	
	public void contextDestroyed(ServletContextEvent event) {
		
	}

	public void contextInitialized(ServletContextEvent event) {
		ServletContext application = null;
		try {
			//系统启动时生成时间戳，并记录
			application = event.getServletContext();
			Long timeStamp = System.currentTimeMillis();
			application.setAttribute("contextInitTimeStamp", String.valueOf(timeStamp));
		} catch (Exception e) {
			application.setAttribute("contextInitTimeStamp", "");
			logger.error("Gets the timestamp when the system starts:" + e.getMessage());
		}
		logger.info("Application Config Start...");
        /*try {
        	URL url = ApplicationConfigListener.class.getClassLoader().getResource("applicationConfig.properties");
            InputStream is = url.openStream();
            if (is == null) {
            	logger.warn("applicationConfig.properties not found.");
            } else {
                Properties prop = new Properties();
                prop.load(is);
                AppConstants.pushIosBookLocation = prop.getProperty(AppConstants.key_pushIosBookLocation);
                AppConstants.pushIosPassword = prop.getProperty(AppConstants.key_pushIosPassword);
                AppConstants.setPushIosProduction(prop.getProperty(AppConstants.key_pushIosProduction));
                
                AppConstants.pushAndroidAppId = prop.getProperty(AppConstants.key_pushAndroidAppId);
                AppConstants.pushAndroidAppKey = prop.getProperty(AppConstants.key_pushAndroidAppKey);
                AppConstants.pushAndroidMaster = prop.getProperty(AppConstants.key_pushAndroidMaster);
                
                AppConstants.siebelWebserviceUsername = prop.getProperty(AppConstants.key_siebelWebserviceUsername);
                AppConstants.siebelWebservicePassword = prop.getProperty(AppConstants.key_siebelWebservicePassword);
                
                AppConstants.appShareFileDir = prop.getProperty(AppConstants.key_appShareFileDir);
                AppConstants.appShareUrlDir = prop.getProperty(AppConstants.key_appShareUrlDir);
                
                AppConstants.portalShareFileDir = prop.getProperty(AppConstants.key_portalShareFileDir);
                AppConstants.portalShareUrlDir = prop.getProperty(AppConstants.key_portalShareUrlDir);
                
                AppConstants.temporaryIOFileDir = prop.getProperty(AppConstants.key_temporaryIOFileDir);
                AppConstants.temporaryIOUrlDir = prop.getProperty(AppConstants.key_temporaryIOUrlDir);
                
                AppConstants.key_applicationRedisHost= prop.getProperty(AppConstants.key_applicationRedisHost);
                
                AppConstants.key_applicationRedisPort =prop.getProperty(AppConstants.key_applicationRedisPort);
                
                AppConstants.key_applicationRedisPassword=prop.getProperty(AppConstants.key_applicationRedisPassword);
                
                AppConstants.key_applicationDatabase = prop.getProperty(AppConstants.key_applicationDatabase);
                AppConstants.key_temporaryIOFileDir2 = prop.getProperty(AppConstants.key_temporaryIOFileDir2);
                AppConstants.key_templatePath = prop.getProperty(AppConstants.key_templatePath);
                
            } 
            is.close();
            //refreshCfg(event);
    		logger.info("Application Config End...");
        } catch (IOException e) {
        	logger.error("I/O Exception reading config properties: " + e.getMessage());
        }*/
        
	}
    /*public void refreshCfg(ServletContextEvent event){
    	try{
    		logger.info("Loading Config from database...");
    		WebApplicationContext appctx = WebApplicationContextUtils.getWebApplicationContext(event.getServletContext());
    		CfgPropertyService cfgPropertyService = (CfgPropertyService) appctx.getBean(CfgPropertyService.class);
    		cfgPropertyService.loadCfg(null);
    	}catch(Exception e){
    		e.printStackTrace();
    		logger.info("Fail to load Config from database: "+e.getMessage());
    	}
    }*/
}
