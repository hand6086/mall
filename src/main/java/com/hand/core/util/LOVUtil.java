package com.hand.core.util;

import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import com.hand.base.basic.service.LovService;

public class LOVUtil {
	
	public static String getLovValue(String type, String name) throws Exception {
		WebApplicationContext wac = ContextLoader.getCurrentWebApplicationContext();
		LovService lovService =  (LovService)wac.getBean(LovService.class);
		return lovService.getLovValue(type, name);
	}


	public static String getLovName(String type, String value) throws Exception {
		WebApplicationContext wac = ContextLoader.getCurrentWebApplicationContext();
		LovService lovService =  (LovService)wac.getBean(LovService.class);
		return lovService.getLovName(type, value);
	}

}
